class Owner < ApplicationRecord
  has_one_attached :image
  has_one :user
  validates :image, presence: true
  validate :correct_image_type

  resourcify
end
