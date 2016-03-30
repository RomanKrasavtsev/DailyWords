require 'json'
require 'open-uri'
require 'net/http'

class TelegramController < ApplicationController
  skip_before_action :require_login

  def index
    token = ENV["BOT"]

    telegram = telegram_params[:message][:text]

    if telegram["ok"]
      chat_id = telegram_params["message"]["chat"]["id"]

      text = "Hello!"
      JSON.load(open("https://api.telegram.org/bot#{token}/sendMessage?chat_id=#{chat_id}&text=#{text}"))
    end
  end

  private

  def telegram_params
    params.permit(
      :update_id,
      :message,
      :telegram
    )
  end
end
