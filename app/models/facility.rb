class Facility < ApplicationRecord
  has_and_belongs_to_many :rooms
  has_many :facilities_estates
  has_many :estates, through: :facilities_estates

  extend Enumerize
  enumerize :facility_type, in: [:estate, :room]

  #def self.options_for_select
  #  order("LOWER(description)").map { |e| [e.description, e.id] }
  #end

end
