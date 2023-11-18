class Gossip < ApplicationRecord
  after_create :set_location
  attr_accessor :tag_ids

  validates :title, presence: true, length: { in: 2..14 }
  validates :content, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }, allow_nil: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_nil: true

  belongs_to :user

  has_many :gossip_tags
  has_many :tags, through: :gossip_tags

  has_many :comments, as: :commentable

  has_many :likes, as: :likeable

  def set_location
    self.longitude = user.longitude
    self.latitude = user.latitude
    save!
  end
end
