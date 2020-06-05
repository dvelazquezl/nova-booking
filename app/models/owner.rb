class Owner < ApplicationRecord
  has_one_attached :image
  has_many :estates
  belongs_to :user
  validates :phone,:address,:about,:user_id,:name, presence: true
  validates :user_id, uniqueness: true
  validates_length_of :phone, minimum: 5, maximum: 20, allow_blank: true
  validates :phone,numericality: { only_integer: true }
  validates_format_of :address, with: /\A[a-zA-Z0-9’'"-\.\/_\u00E0-\u00FC\s]+\z/
  validates_format_of :about, with: /\A[a-zA-Z0-9\[\]{}\\*:;@$%&#?!¡|’'"-\.\/_\u00E0-\u00FC\s]+\z/

  def estates_average
    estates.map(&:score).sum / (estates.count > 0 ? estates.count : 1)
  end

  resourcify
end
