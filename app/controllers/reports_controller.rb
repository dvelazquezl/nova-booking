class ReportsController < ApplicationController
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
      format.pdf { render template: 'reports/most_valuated_estates', pdf: 'Alojamientos mas valorados', page_size: 'A4', lowquality: true,
                          zoom: 1, layout: 'pdf.html', dpi: 75 }
    end

    render :most_valuated_estates, locals: {estates: @estates}
  end
end
