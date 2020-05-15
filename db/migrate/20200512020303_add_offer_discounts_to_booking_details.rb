class AddOfferDiscountsToBookingDetails < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'hstore'
    add_column :booking_details, :offer_discounts, :hstore, array: true
  end
end
