class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :last_name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :last_name, :password, :password_confirmation, :current_password])
  end

  #Excepcion de acceso denegado.
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to welcome_index_path, :alert => 'Acceso denegado.' }
    end
  end

  def convert_base64_to_file(estate, images)
    images.each do |image|
      decoded_data = Base64.decode64(image.split(',')[1])
      image_io = StringIO.new(decoded_data)
      image_io = handle_string_io_as_file(image_io, 'image.png')
      estate.images.attach(
          io: image_io,
          filename: 'image-' + current_user.id.to_s + '-' + Time.current.to_s + '.png',
          content_type: 'image/png'
      )
    end
  end

  def handle_string_io_as_file(io, filename)
    return io unless io.class == StringIO

    file = Tempfile.new([filename, ".png"], encoding: 'ascii-8bit')
    file.binmode
    file.write io.read
    file.open
  end
end