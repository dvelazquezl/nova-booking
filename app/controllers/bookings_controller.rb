class BookingsController < ApplicationController
  before_action :authenticate_user! , except: :show
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @booking.client_name = params[:client_name]
    @booking.date_start = params[:date_start]
    @booking.date_end = params[:date_start]
    @booking.total_amount = params[:total_amount]
    @booking.booking_state = true
    params[:booking_details].each_pair {|key,value|
      @booking.booking_details.build(room_id: value["room_id"],
                                     quantity: value["quantity"],
                                     subtotal: value["subtotal"])
      }
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def create
    @booking = Booking.new(booking_params)

    respond_to do |format|
      if @booking.save
        format.html { redirect_to @booking, notice: 'La reserva fue creado satifactoriamente.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'La reserva fue actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'La reserva fue eliminado satifactoriamente.' }
      format.json { head :no_content }
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:client_name, :client_email, :date_start, :date_end, :date_creation, :total_amount, :booking_state, booking_details_attributes: [:id, :booking_id, :room_id, :quantity, :subtotal])
  end
end
