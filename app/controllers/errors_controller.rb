class ErrorsController < ApplicationController
  layout 'errors'

  def not_found
    respond_to do |format|
      format.html { render status: 404 }
      format.json { render json: { error: "Page not found" }, status: 404 }
    end
  end

  def internal_server_error
    respond_to do |format|
      format.html { render status: 500 }
      format.jso { render json: { error: "Internal server error" }, status: 500 }
    end
  end
end
