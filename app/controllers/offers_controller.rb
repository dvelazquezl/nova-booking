class OffersController < ApplicationController
  authorize_resource
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  # GET /offers
  # GET /offers.json
  def index
    offers = []
    owner = helpers.current_owner
    if owner
      (@filterrific = initialize_filterrific(
          Offer.offers_by_owner(owner),
          params[:filterrific],
          select_options: {
              search_status: Offer.offer_status.options,
              by_estate: Estate.options_for_by_estate(owner.id)
          },
      )) || return
      offers = @filterrific.find.page(params[:page])
      respond_to do |format|
        format.html
        format.js
      end
    end
    render :index, locals: {offers: offers, filterrific: @filterrific}
  end

  # GET /offers/1
  # GET /offers/1.json
  def show
  end

  # GET /offers/new
  def new
    @offer = Offer.new
    @offer.set_default_date
    owner = helpers.current_owner
    estates = Estate.only_published.estates_by_owner(owner.id)
    offer_details = @offer.offer_details.build
    if params[:tag_estate_id].present? then
      @offer.estate_id = params[:tag_estate_id]
    end
    from_estates = params[:from_estates].present? ? true : false
    render :new, locals: {offer_details: offer_details, estates: estates, from_estates: from_estates}

  end

  # GET /offers/1/edit
  def edit
    @offer.date_start = @offer.date_start.strftime("%Y-%m-%d")
    @offer.date_end = @offer.date_end.strftime("%Y-%m-%d")
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)
    @offer.date_creation = Time.now
    respond_to do |format|
      if @offer.save
        format.html { redirect_to @offer, notice: 'La oferta fue creada satisfactoriamente.' }
      else
        owner = helpers.current_owner
        estates = Estate.only_published.estates_by_owner(owner.id)
        flash[:alert] = "No se pudo crear la oferta. Seleccione una propiedad."
        format.html { render :new, locals: {offer_details: nil, estates: estates, estate_name: nil, from_estates: false} }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_offer
    @offer = Offer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def offer_params
    params.require(:offer).permit(:description, :date_start, :date_end, :date_creation, :estate_id, offer_details_attributes: [:id, :offer_id, :room_id, :discount])
  end

  def current_ability
    @current_ability ||= OfferAbility.new(current_user)
  end
end
