class ErrorsController < ApplicationController
  layout 'error'

  def not_found_error
    respond_to do |format|
      format.html { render status: 404 }
    end
  end

  def server_error
    respond_to do |format|
      format.html { render status: 500 }
    end
  end
end
