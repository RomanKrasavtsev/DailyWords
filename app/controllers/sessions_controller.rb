class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    if current_user
      redirect_to new_review_path
    else
      @user = User.new
    end
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to new_review_path
    else
      flash[:error] = t(:login_failed)
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
