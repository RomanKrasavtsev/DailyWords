class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @title = "Регистрация"
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @title = "Настройки"
    @user = current_user
    @quantity = current_user.cards.count
  end

  def update
    if User.authenticate(current_user.email, params[:user][:old_password])
      current_user.change_password!(params[:user][:password])
      current_user.update(email: params[:user][:email])
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
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
