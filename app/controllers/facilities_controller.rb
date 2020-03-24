#controller for creating, editing, and deleting facilities
class FacilitiesController < ApplicationController
  before_action :set_facility, only: [:edit, :update, :destroy]

  def index
    @facilities = Facility.page(params[:page])
    render :index, locals: { facilities: @facilities }
  end

  def new
    @facility = Facility.new
  end

  def edit
  end

  def create
    @facility = Facility.new(facility_params)
    respond_to do |format|
      if @facility.save
        format.html { redirect_to facilities_url, notice: 'Comodidad creada exitosamente.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @facility.update(facility_params)
        format.html { redirect_to facilities_url, notice: 'Comodidad actualizada exitosamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @facility.destroy
    respond_to do |format|
      format.html { redirect_to facilities_url, notice: 'Comodidad eliminada exitosamente.' }
    end
  end

  private
  def set_facility
    @facility = Facility.find(params[:id])
  end

  def facility_params
    params.require(:facility).permit(:description, :facility_type)
  end
end
