class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:linkedin]

  #comment this out when seeding
  after_create  :manual_business_card

  has_one :business_card, dependent: :destroy
  has_many :connections, dependent: :destroy
  has_many :contacts, through: :connections, :foreign_key => 'contact_id'

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def self.find_for_linkedin_oauth(auth)
    bc_params = {}
    user_params = auth.slice(:provider, :uid)
    user_params[:email] = auth.info.email
    bc_params[:first_name] = auth.info.first_name
    bc_params[:last_name] = auth.info.last_name
    bc_params[:email] = auth.info.email
    client = LinkedIn::Client.new
    client.authorize_from_access(auth.extra.access_token.token, auth.extra.access_token.secret)
    bc_params[:linkedin_picture_url] = client.picture_urls.all.first
    user_params[:token] = auth.credentials.token
    bc_params[:industry] = auth.info.industry
    bc_params[:location] = auth.info.location
    bc_params[:phone] = auth.info.phone
    bc_params[:linkedin_profile_url] = auth.info.urls.public_profile
    bc_params[:description] = auth.info.description
    # user_params[:token_expiry] = Time.at(auth.extra.oauth_authorization_expires_in)
    user_params = user_params.to_h


    user = User.where(provider: auth.provider, uid: auth.uid).first
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
      user.business_card.update(bc_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.business_card = BusinessCard.create(bc_params)
      user.save
    end

    return user
  end

  def get_contacts_business_card
    business_card_arr = []
    self.contacts.each do |contact|
      business_card_arr << contact.business_card
    end
    return business_card_arr
  end

  def manual_business_card
    if self.provider == nil
      self.business_card = BusinessCard.create(email: self.email)
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

end

