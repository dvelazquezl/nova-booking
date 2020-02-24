class Room < ApplicationRecord
  has_and_belongs_to_many :facilities
  belongs_to :estate
end
