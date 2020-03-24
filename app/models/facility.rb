class Facility < ApplicationRecord

  has_many :facilities_estates
  has_many :estates, through: :facilities_estates
  has_many :facilities_rooms
  has_many :rooms, through: :facilities_rooms


  extend Enumerize
  enumerize :facility_type, in: [:estate, :room]

  self.per_page = 10
  #def self.options_for_select
  #  order("LOWER(description)").map { |e| [e.description, e.id] }
  #end

end
