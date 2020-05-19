class City < ApplicationRecord
  belongs_to :departament
  has_many :estates
  delegate :name, :to => :departament, :prefix => true
  validates :name, presence: true, format: { with: /\A[a-zA-Z'-]*\z/ }

  self.per_page = 5
  resourcify
end
