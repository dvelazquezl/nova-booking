class BookingsController < ApplicationController
  before_action :authenticate_user! , except: [:new, :create, :show]
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  def show
    if !@booking.booking_state.blank?
      @booking = Booking.find(params[:id])
      @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
    else
      format.html { redirect_to root_url, errors: 'Lo sentimos no puede acceder a la reserva' }
    end
  end

  def new
    @booking = Booking.booking_new(Booking.new, params)
  end

  def create
    @booking = Booking.new(booking_params)
    respond_to do |format|
      if @booking.save
        @estate = Estate.find(Room.find(@booking.booking_details[0].room_id).estate_id)
        if user_signed_in?
          set_state(@booking)
          format.html { redirect_to @booking, notice: 'La reserva fue creada satifactoriamente.'}
          format.json { render :show, status: :created, location: @booking }
        else
          format.html { redirect_to root_url, notice: 'Verifique su correo para la confirmación de la reserva..'}
          UserMailer.new_booking_confirmation(@booking).deliver_now
        end

      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'La reserva fue actualizada correctamente.'}
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

  def confirmation
    if params[:confirmation_token].present?
      @booking = Booking.find_by_confirmation_token(params[:confirmation_token])
      set_state(@booking)
      respond_to do |format|
        format.html { redirect_to @booking, notice: 'La reserva fue creada satifactoriamente.'}
        format.json { render :show, status: :created, location: @booking}
      end
    else
      format.html { redirect_to bookings_url, error: 'Los sentimos se ha producido un error.' }
    end
  end
  private

  def set_state(booking)
    booking.confirmed_at = Time.now()
    booking.booking_state = true
    booking.save
    UserMailer.new_booking(booking).deliver_now
    UserMailer.new_booking_owner(booking).deliver_now
  end
  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:client_name, :client_email, :date_start, :date_end, :date_creation, :total_amount, :booking_state, booking_details_attributes: [:id, :booking_id, :room_id, :quantity, :subtotal])
  end
end
