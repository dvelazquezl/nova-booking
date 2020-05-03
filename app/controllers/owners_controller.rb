class OwnersController < ApplicationController

  before_action :authenticate_user! , except: :show
  before_action :set_owner, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  require 'base64'
  def index
    @owners = Owner.all
  end

  def show
    @user = User.find(@owner.user_id)
  end

  def new
    @owner = Owner.new
  end

  def edit
    @user = User.find(@owner.user_id)
  end

  def create
    @owner = Owner.new(owner_params)
    user = User.find(@owner.user_id)
    @owner.name = user.name + user.last_name
    decoded_data = Base64.decode64(params[:image].split(',')[1])
    image_io = StringIO.new(decoded_data)
    image_io = handle_string_io_as_file(image_io, 'image.png')
    @owner.image.attach(
        io: image_io,
        filename: 'image-'+current_user.id.to_s+'-'+Time.current.to_s+'.png',
        content_type: 'image/png'
    )
    respond_to do |format|
      if @owner.save
        format.html { redirect_to @owner, notice: 'Propietario fue creado satifactoriamente.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    decoded_data = Base64.decode64(params[:image].split(',')[1])
    image_io = StringIO.new(decoded_data)
    image_io = handle_string_io_as_file(image_io, 'image.png')
    @owner.image.attach(
        io: image_io,
        filename: 'image-'+current_user.id.to_s+'-'+Time.current.to_s+'.png',
        content_type: 'image/png'
    )
    respond_to do |format|
      if @owner.update(owner_params)
        format.html { redirect_to @owner, notice: 'Tu perfil fue actualizado correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @owner.destroy
    respond_to do |format|
      format.html { redirect_to owners_url, notice: 'Propietario fue eliminado satifactoriamente.' }
    end
  end

  private

  def set_owner
    @owner = Owner.find(params[:id])
  end

  def owner_params
    params.require(:owner).permit(:phone, :address, :about, :name, :email, :user_id)
  end

  def current_ability
    @current_ability ||= OwnerAbility.new(current_user)
  end

  def handle_string_io_as_file(io, filename)
    return io unless io.class == StringIO

    file = Tempfile.new([filename,".png"], encoding: 'ascii-8bit')
    file.binmode
    file.write io.read
    file.open
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end