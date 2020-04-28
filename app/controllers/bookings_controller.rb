class BookingsController < ApplicationController
  authorize_resource
  before_action :authenticate_user!, except: [:new, :create, :show, :confirmation]
  before_action :set_booking, only: [:show, :destroy]

  def index_owner
    owner = helpers.current_owner
    if owner
      @bookings = Booking.bookings_by_owner_id(owner.id).page(params[:page])
    end
    render :index_owner, locals: {bookings: @bookings}
  end

  def index_user
    email = current_user.email
    if email
      @bookings = Booking.bookings_by_client(email).page(params[:page])
    else
      @bookings = []
    end
    render :index_user, locals: {bookings: @bookings}
  end

  def show
    @booking = Booking.find(params[:id])
    if !@booking.booking_state.blank?
      room = Room.with_deleted.find(@booking.booking_details[0].room_id)
      @estate = Estate.with_deleted.find(room.estate_id)
      @diff = Booking.diff(@booking)
      @plural_arg = (@diff > 1) ? "s" : " "
    else
      format.html { redirect_to root_url, errors: 'Lo sentimos no puede acceder a la reserva' }
    end
  end

  # GET /bookings/show_detail/1
  def show_detail
    @booking = Booking.find(params[:id])
    #para saber si la reserva corresponde al actual owner logueado
    its_the_current_owner = helpers.estate_by_booking(@booking).owner_id == helpers.current_owner.id
    if !@booking.booking_state.blank? && its_the_current_owner
      room = Room.with_deleted.find(@booking.booking_details[0].room_id)
      @estate = Estate.with_deleted.find(room.estate_id)
      @diff = Booking.diff(@booking)
      @plural_arg = (@diff > 1) ? "s" : " "
    else
      format.html { redirect_to root_url, errors: 'Lo sentimos no puede acceder a la reserva' }
    end
    render :show_detail, locals: {booking: @booking, estate: @estate, diff: @diff, plural_arg: @plural_arg}
  end

  def new
    @booking = Booking.booking_new(Booking.new, params)
    @diff = Booking.diff(@booking)
    @plural_arg = (@diff > 1) ? "s" : " "
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.notified = false
    respond_to do |format|
      if @booking.save
        @estate = Booking.estate(@booking)
        if user_signed_in?
          Booking.set_state(@booking)
          format.html { redirect_to @booking, notice: 'La reserva fue creada satifactoriamente.' }
        else
          format.html { redirect_to root_url, notice: 'Verifique su correo para la confirmación de la reserva..' }
          UserMailer.new_booking_confirmation(@booking).deliver_now
        end
      else
        format.html { render :new }
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
      Booking.set_state(@booking)
      respond_to do |format|
        format.html { redirect_to @booking, notice: 'La reserva fue creada satifactoriamente.' }
        format.json { render :show, status: :created, location: @booking }
      end
    else
      format.html { redirect_to bookings_url, error: 'Los sentimos se ha producido un error.' }
    end
  end

  def cancel_booking_owner
    booking = Booking.find(params[:id])
    respond_to do |format|
      if booking.update_attribute(:booking_state, 'false')
        format.html { redirect_to index_owner_bookings_url, notice: 'La reserva fue cancelada satifactoriamente.' }
        format.json { head :no_content }
        UserMailer.booking_canceled_by_owner_to_owner(booking).deliver_now
        UserMailer.booking_canceled_by_owner_to_client(booking).deliver_now
      else
        format.html { redirect_to index_owner_bookings_url, alert: 'No se pudo cancelar.' }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:client_name, :client_email, :date_start, :date_end, :date_creation, :total_amount, :booking_state, :estate_id, booking_details_attributes: [:id, :booking_id, :room_id, :quantity, :subtotal])
  end

  def current_ability
    @current_ability ||= BookingAbility.new(current_user)
  end
end
