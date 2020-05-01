class OfferDetail < ApplicationRecord
  belongs_to :room
  belongs_to :offer

  def price_with_discount(price)
    return price_with_discount = (price - price*self.discount/100)
  end
end
