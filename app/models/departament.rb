class Departament < ApplicationRecord
  has_many :cities
  validates :name, presence: true, format: { with: /\A[a-zA-Z'-]*\z/ }

  self.per_page = 5
  resourcify
end
