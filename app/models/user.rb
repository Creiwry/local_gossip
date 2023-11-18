class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "must be a valid email address"
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :city, presence: true
  validates :age, presence: true
  validates :description, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }, allow_nil: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true

  belongs_to :city
  has_many :gossips

  has_many :sent_messages, class_name: 'PrivateMessage', foreign_key: 'sender_id'
  has_many :message_recipients, foreign_key: :recipient_id
  has_many :received_messages, through: :message_recipients, source: :private_message

  has_many :comments

  has_many :likes
end
