class ReportsController < ApplicationController
  load_and_authorize_resource

  # alojamientos mas valorados
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

  private

  def current_ability
    @current_ability ||= ReportAbility.new(current_user)
  end
end
