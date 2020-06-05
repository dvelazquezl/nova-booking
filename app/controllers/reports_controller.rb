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
      format.html do
        render :most_valuated_estates, locals: {estates: @estates}
      end
      format.pdf do
        render javascript_delay: 5000,
               locals: {estates: @estates},
               template: "reports/most_valuated_estates.pdf.erb",
               page_size: 'A4',
               header:  {
                   html: {
                       template: 'layouts/partials/_pdf_header.html.erb',
                       layout: 'layouts/decoration_pdf.html.erb'
                   }
               },
               footer:  {
                   html: {
                       template: 'layouts/partials/_pdf_footer.html.erb',
                       layout: 'layouts/decoration_pdf.html.erb'
                   }
               },
               pdf: "Propiedades_mas_valuadas.pdf"
        end
      format.js
    end


  end
  # alojamientos mas comentados
  def most_commented_estates
    (@filterrific = initialize_filterrific(
      Estate.most_commented,
      params[:filterrific]
    )) || return
    @estates = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html do
        render :most_commented_estates, locals: {estates: @estates}
      end
      format.js
      format.pdf do
        render javascript_delay: 5000,
               locals: {estates: @estates},
               template: "reports/most_commented_estates.pdf.erb",
               page_size: 'A4',
               header:  {
                   html: {
                       template: 'layouts/partials/_pdf_header.html.erb',
                       layout: 'layouts/decoration_pdf.html.erb'
                   }
               },
               footer:  {
                   html: {
                       template: 'layouts/partials/_pdf_footer.html.erb',
                       layout: 'layouts/decoration_pdf.html.erb'
                   }
               },
               pdf: "Propiedades_mas_comentadas.pdf"
      end
    end
  end

  private

  def current_ability
    @current_ability ||= ReportAbility.new(current_user)
  end
end
