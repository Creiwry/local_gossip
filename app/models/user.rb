class User < ApplicationRecord
  belongs_to :city
  has_many :gossips

  has_many :sent_messages, class_name: 'PrivateMessage', foreign_key: 'sender_id'
  has_many :message_recipients, foreign_key: :recipient_id
  has_many :received_messages, through: :message_recipients, source: :private_message

  has_many :comments

  has_many :likes
end
