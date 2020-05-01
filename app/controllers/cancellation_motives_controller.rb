class CancellationMotivesController < ApplicationController
  before_action :set_cancellation_motive, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @cancellation_motives = CancellationMotive.all
    render :index, locals: { cancellation_motives: @cancellation_motives }
  end

  def show
  end

  def new
    @canellation_motive = CancellationMotive.new
  end

  def edit
  end

  def create
    @cancellation_motive = CancellationMotive.new(cancellation_motive_params)

    respond_to do |format|
      if @cancellation_motive.save
        format.html { redirect_to @cancellation_motive, notice: 'Motivo de cancelacion creado exitosamente.' }
        format.json { render :show, status: :created, location: @cancellation_motive }
      else
        format.html { render :new }
        format.json { render json: @cancellation_motive.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @cancellation_motive.update(cancellation_motive_params)
        format.html { redirect_to @cancellation_motive, notice: 'Motivo de cancelacion actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @cancellation_motive }
      else
        format.html { render :edit }
        format.json { render json: @cancellation_motive.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cancellation_motive.destroy
    respond_to do |format|
      format.html { redirect_to cancellation_motives_url, notice: 'Motivo de cancelacion eliminada exitosamente.' }
      format.json { head :no_content }
    end
  end

  private

  def set_cancellation_motive
    @cancellation_motive = CancellationMotive.find(params[:id])
  end

  def cancellation_motive_params
    params.require(:cancellation_motive).permit(:description)
  end

  def current_ability
    @current_ability ||= CancellationMotiveAbility.new(current_user)
  end
end
