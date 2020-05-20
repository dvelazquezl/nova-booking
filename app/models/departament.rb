class Departament < ApplicationRecord
  has_many :cities
  validates :name, format: { with: /\A[a-zA-ZÀ-ÿ]+\z/ }

  self.per_page = 5
  resourcify
end
