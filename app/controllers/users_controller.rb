class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def show
  end

  def edit
    @owner = Owner.find_by_user_id(current_user.id)
  end

  def update
    @owner.name = @user.name + " " + @user.last_name
    respond_to do |format|
      if @user.update_without_password(user_params) and @owner.update_attributes(owner_params)
        format.html { redirect_to owner_path(@owner), notice: 'Tu perfil fue actualizado correctamente.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    @owner = Owner.find_by_user_id(@user.id)
  end

  def user_params
    params.require(:user).permit(:name, :last_name, :username)
  end

  def owner_params
    params.require(:owner).permit(:phone, :address, :about, :name, :email, :user_id)
  end
end
