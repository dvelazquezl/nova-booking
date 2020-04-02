class BookingsController < ApplicationController
  before_action :authenticate_user! , except: [:new, :create, :show]
  before_action :set_booking, only: [:show, :edit, :update]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
    @diff = Booking.diff(@booking)
    @plu = (@diff > 1)? "s":" "
  end

  def new
    @booking = Booking.booking_new(Booking.new, params)
    @diff = Booking.diff(@booking)
    @plu = (@diff > 1)? "s":" "
  end

  def edit
    @booking = Booking.find(params[:id])
    @diff = Booking.diff(@booking)
    @plu = (@diff > 1)? "s":" "
  end

  def create
    @booking = Booking.new(booking_params)
    respond_to do |format|
      if @booking.save
        @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
        format.html { redirect_to @booking, notice: 'La reserva fue creado satifactoriamente.' }
        format.json { render :show, status: :created, location: @booking }
        UserMailer.new_booking(@booking).deliver_now
        UserMailer.new_booking_owner(@booking).deliver_now
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

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:client_name, :client_email, :date_start, :date_end, :date_creation, :total_amount, :booking_state, booking_details_attributes: [:id, :booking_id, :room_id, :quantity, :subtotal])
  end
end
