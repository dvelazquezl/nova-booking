class Departament < ApplicationRecord
  has_many :cities
  self.per_page = 5
  resourcify
end
