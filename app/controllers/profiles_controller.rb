class ProfilesController < ApplicationController
  def edit
    @user = current_user
    @quantity = current_user.cards.count
  end

  def update
    if User.authenticate(current_user.email, user_params[:old_password])
      if current_user.update(
          email: user_params[:email],
          password: user_params[:password],
          password_confirmation: user_params[:password_confirmation],
          telegram_id: user_params[:telegram_id]
        )  
        flash[:true] = t(:profile_updated)
        redirect_to settings_path
      else
        @user = current_user
        render "edit"
      end
    else
      flash[:error] = t(:wrong_password)
      redirect_to settings_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :telegram_id, :old_password, :password, :password_confirmation)
  end
end
