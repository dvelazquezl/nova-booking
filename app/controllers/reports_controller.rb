# frozen_string_literal: true

# reports controller
class ReportsController < ApplicationController
  load_and_authorize_resource

  def index; end

  # alojamientos mas valoradosPa
  def most_valuated_estates
    (@filterrific = initialize_filterrific(
      Estate.best_estates,
      params[:filterrific]
    )) || return
    @estates = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

    render :most_valuated_estates, locals: {estates: @estates}
  end

  # alojamientos mas comentados
  def most_commented_estates
    (@filterrific = initialize_filterrific(
      Estate.most_commented,
      params[:filterrific]
    )) || return
    @estates = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

    render :most_commented_estates, locals: {estates: @estates}
  end

  # alojamientos mas reservados
  def most_booked_estates
    (@filterrific = initialize_filterrific(
        Estate.most_booked,
        params[:filterrific]
    )) || return
    @estates = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end

    render :most_booked_estates, locals: {estates: @estates}
  end

  private

  def current_ability
    @current_ability ||= ReportAbility.new(current_user)
  end
end
