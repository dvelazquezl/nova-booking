class City < ApplicationRecord
  belongs_to :departament
  has_many :estates
  delegate :name, :to => :departament, :prefix => true
  validates :name, presence: true, format: { with: /\A[a-zA-ZÀ-ÿ\-\s]{2,50}\z/i }

  self.per_page = 10
  resourcify
end
