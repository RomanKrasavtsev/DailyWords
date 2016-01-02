class LoginsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to root_path
    else
      flash[:error] = "Неверный логин или пароль!"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
