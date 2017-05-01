class ConnectionRequest < ApplicationRecord
  belongs_to :user
  belongs_to :contact, class_name: 'User'

  validates :user, presence: true
  validates :contact, presence: true, uniqueness: { scope: :user }

  validate :not_self
  validate :not_pending
  # validate :not_contacts

  def accept
    Connection.create(user: self.user, contact: self.contact)
    Connection.create(user: self.contact, contact: self.user)
    destroy
  end

  private

  def not_self
    errors.add(:contact_id, "can't be equal to user") if user == contact
  end

  def not_pending
    errors.add(:contact_id, "already requested connection") if contact.pending_connections.include?(user)
  end

  # def not_contacts
  #   errors.add(:friend, "is already added") if user.friends.include?(friend)
  # end
end
