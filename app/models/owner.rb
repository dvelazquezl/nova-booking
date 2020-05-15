class Owner < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  validates :phone,:address,:about,:user_id,:name, presence: true
  validates :user_id, uniqueness: true
  validates_length_of :phone, minimum: 5, maximum: 20, allow_blank: true
  validates :phone,numericality: { only_integer: true }
  validates_format_of :address, with: /\A[a-zA-Z0-9!|’'"-\.\/_\s]+\z/
  validates_format_of :about, with: /\A[a-zA-Z0-9\[\]{}\\*:;@$%&#?!|’'"-\.\/_\s]+\z/

  resourcify
end
