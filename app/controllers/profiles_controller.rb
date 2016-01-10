class ProfilesController < ApplicationController
  def edit
    @user = current_user
    @quantity = current_user.cards.count
  end

  def update
    if User.authenticate(current_user.email, user_params[:old_password])
      if user_params[:password] != user_params[:password_confirmation]
        flash[:error] = t(:confirmation)
        redirect_to settings_path
        return
      end

      current_user.change_password!(user_params[:password])
      current_user.update(email: user_params[:email])
      flash[:true] = t(:profile_updated)
      redirect_to settings_path
    else
      flash[:error] = t(:wrong_password)
      redirect_to settings_path
      return
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :old_password, :password, :password_confirmation)
  end
end
