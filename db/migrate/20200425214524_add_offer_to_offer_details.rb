class AddOfferToOfferDetails < ActiveRecord::Migration[5.2]
  def change
    add_reference :offer_details, :offer, foreign_key: true
  end
end
