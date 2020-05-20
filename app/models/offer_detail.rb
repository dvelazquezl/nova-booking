class OfferDetail < ApplicationRecord
  belongs_to :room
  belongs_to :offer

  validates :discount, numericality: { greater_than: 0, less_than: 100 }

  def price_with_discount(price)
    return price_with_discount = (price - price*self.discount/100)
  end
end
