require 'json'
require 'open-uri'
require 'net/http'

class TelegramController < ApplicationController
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token

  def index
    token = ENV["BOT"]

    logger.info telegram_params
    # telegram = telegram_params[:message][:text]

    # if telegram["ok"]
    #   chat_id = telegram_params["message"]["chat"]["id"]

    #   text = "Hello!"
    #   JSON.load(open("https://api.telegram.org/bot#{token}/sendMessage?chat_id=#{chat_id}&text=#{text}"))
    # end

    #JSON.load(open("https://api.telegram.org/bot#{token}/sendMessage?chat_id=13344296&text=Hi"))
  end

  private

  def telegram_params
    params.permit(
      :update_id,
      :message => [
        :message_id,
        :from => [
          :id,
          :first_name,
          :last_name,
          :username
        ],
        :chat => [
          :id,
          :first_name,
          :last_name,
          :username,
          :type
        ],
        :date,
        :text
      ],
      :telegram => [
        :update_id,
        :message => [
          :message_id,
          :from => [
            :id,
            :first_name,
            :last_name,
            :username
          ],
          :chat => [
            :id,
            :first_name,
            :last_name,
            :username,
            :type
          ],
          :date,
          :text
        ]
      ]
    )
  end
end
