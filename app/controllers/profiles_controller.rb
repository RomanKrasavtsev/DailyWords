class ProfilesController < ApplicationController
	def edit
    @user = current_user
    @quantity = current_user.cards.count
  end

  def update
    if User.authenticate(current_user.email, user_params[:old_password])
      current_user.change_password!(user_params[:password])
      current_user.update(email: user_params[:email])
      flash[:true] = "Ваши данные успешно изменены"
      redirect_to settings_path
    else
      flash[:error] = "Неверно указан текущий пароль!"
      @user = current_user
      render "edit"
    end
  end

  private

  def user_params
    params.requere(:user).permit(:email, :old_password, :password)
  end
end