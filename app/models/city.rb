class City < ApplicationRecord
  belongs_to :departament
  has_many :estates
end
