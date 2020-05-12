class Owner < ApplicationRecord
  has_one_attached :image
  has_one :user

  resourcify
end
