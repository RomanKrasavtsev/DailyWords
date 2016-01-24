class SettingsController < ApplicationController
  before_action :get_quantity
  before_action :set_user, only: [:index, :email, :password, :telegram]

  def index
  end

  def email
  end

  def update_email
    if User.authenticate(current_user.email, user_params[:password])
      if current_user.update(
          email: user_params[:email]
        )
        flash[:true] = t(:profile_updated)
        redirect_to settings_path
      else
        @user = current_user
        render "email"
      end
    else
      flash[:error] = t(:wrong_password)
      redirect_to settings_email_path
    end
  end

  def password
  end

  def update_password
    if User.authenticate(current_user.email, user_params[:password])
      if current_user.update(
          password: user_params[:new_password],
          password_confirmation: user_params[:new_password_confirmation]
        )  
        flash[:true] = t(:profile_updated)
        redirect_to settings_path
      else
        @user = current_user
        render "password"
      end
    else
      flash[:error] = t(:wrong_password)
      redirect_to settings_password_path
    end
  end

  def telegram
  end

  def update_telegram
    if User.authenticate(current_user.email, user_params[:password])
      if current_user.update(
          telegram_id: user_params[:telegram_id],
          time_from: user_params[:time_from],
          time_to: user_params[:time_to]
        )  
        flash[:true] = t(:profile_updated)
        redirect_to settings_path
      else
        @user = current_user
        render "telegram"
      end
    else
      flash[:error] = t(:wrong_password)
      redirect_to settings_telegram_path
    end
  end

  private

  def set_user
    @user ||= current_user
  end

  def get_quantity
    @quantity = current_user.cards.count
  end

  def user_params
    params.require(:user).permit(
      :email,
      :telegram_id,
      :time_from,
      :time_to,
      :password,
      :new_password,
      :new_password_confirmation
    )
  end
end
