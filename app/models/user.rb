class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:linkedin]

  def self.find_for_linkedin_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:linkedin_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:industry] = auth.info.industry
    user_params[:location] = auth.info.location
    user_params[:phone] = auth.info.phone
    user_params[:linkedin_profile_url] = auth.info.urls.public_profile
    user_params[:description] = auth.info.description
    # user_params[:token_expiry] = Time.at(auth.extra.oauth_authorization_expires_in)
    user_params = user_params.to_h

    user = User.where(provider: auth.provider, uid: auth.uid).first
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end
end

