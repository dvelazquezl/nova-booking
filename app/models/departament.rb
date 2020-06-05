class Departament < ApplicationRecord
  has_many :cities
  validates :name, presence: true, format: { with: /\A[a-zA-ZÀ-ÿ\-\s]{2,50}\z/i }

  self.per_page = 10
  resourcify
end
