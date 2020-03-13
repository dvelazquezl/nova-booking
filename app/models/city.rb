class City < ApplicationRecord
  belongs_to :departament
  has_many :estates

  delegate :name, :to => :departament, :prefix => true
end
