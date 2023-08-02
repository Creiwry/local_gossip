class Gossip < ApplicationRecord
  attr_accessor :tag_ids

  validates :title, presence: true, length: { in: 2..14 }
  validates :content, presence: true

  belongs_to :user

  has_many :gossip_tags
  has_many :tags, through: :gossip_tags

  has_many :comments, as: :commentable

  has_many :likes, as: :likeable
end
