class Room < ApplicationRecord
  has_and_belongs_to_many :facilities
  belongs_to :estate

  extend Enumerize

  enumerize :room_type, in: [:single, :double, :family]
  enumerize :status, in: [:published, :not_published]

end
