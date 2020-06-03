# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    quantity_hotels = 15
    (@filterrific = initialize_filterrific(
        Estate,
        params[:filterrific],
        select_options: {
            sorted_by: Estate.options_for_sorted_by,
        },
        )) || return
    estates = Estate.only_published.best_estates.take(quantity_hotels)
    estates_best_offers = Estate.only_published.best_offers.take(quantity_hotels)

    respond_to do |format|
      format.html
      format.js
    end

    render :index, locals: { filterrific: @filterrific, estates: estates, estates_best_offers: estates_best_offers}
  end

  def resources
    cities = City.all
    estates = Estate.only_published
    array_of_json = cities + estates
    respond_to do |format|
      format.json { render json: array_of_json.to_json( :only => [:name])  }
    end
  end

  def results
    params[:filterrific]["price_min"] = params[:filterrific]["price_min"] == '' ? '0' : params[:filterrific]["price_min"]
    params[:filterrific]["price_max"] = params[:filterrific]["price_max"] == '' ? '1000000000' : params[:filterrific]["price_max"] #to do
    params[:filterrific]["with_date_gte"] = Date.parse(params[:filterrific]["with_date_gte"])
    params[:filterrific]["with_date_lte"] = Date.parse(params[:filterrific]["with_date_lte"])
    (@filterrific = initialize_filterrific(
        Estate,
        params[:filterrific],
        select_options: {
            sorted_by: Estate.options_for_sorted_by,
            with_estate_type: Estate.estate_type.options,
            search_booking_cancelable: Estate.booking_cancelable_status.options,
            with_facilities: Facility.options_for_select
        },
        )) || return
    @estates = @filterrific.find.page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
    render :results, locals: {filterrific: @filterrific}
  end

end
