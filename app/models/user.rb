class User < ApplicationRecord

  has_many :requests_sent, class_name: 'Request', foreign_key: 'sender_id'
  has_many :requests_received, class_name: 'Request', foreign_key: 'receiver_id'

  has_many :friends, class_name: 'Friend', foreign_key: 'friend_id'
  has_many :chatters, class_name: 'Friend', foreign_key: 'user_id'

  validates :facebook_id, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, uniqueness: true
  validates :screen_name, uniqueness: true
end
