require 'json'
require 'open-uri'
require 'net/http'

class TelegramController < ApplicationController
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token

  def index
    token = ENV["BOT"]
    text = params[:message][:text]

    if text == "ok"
      chat_id = params["message"]["chat"]["id"]

      answer = prepare_message("Привет! Ваш ID: #{chat_id}")
        logger.debug "###### #{answer}"
      JSON.load(open("https://api.telegram.org/bot#{token}/sendMessage?chat_id=#{chat_id}&text=#{answer}"))
    end

  end

  private

  def prepare_message(text)
    text.gsub!(" ","%20").gsub!("+","%2B")
  end

  def telegram_params
    # params.permit(
    #   :update_id,
    #   message: {
    #     :message_id,
    #     from: {
    #       :id,
    #       :first_name,
    #       :last_name,
    #       :username
    #     },
    #     chat: {
    #       :id,
    #       :first_name,
    #       :last_name,
    #       :username,
    #       :type
    #     },
    #     :date,
    #     :text
    #   },
    #   telegram: {
    #     :update_id,
    #     message: {
    #       :message_id,
    #       from: {
    #         :id,
    #         :first_name,
    #         :last_name,
    #         :username
    #       },
    #       chat: {
    #         :id,
    #         :first_name,
    #         :last_name,
    #         :username,
    #         :type
    #       },
    #       :date,
    #       :text
    #     }
    #   }
    # )
  end
end
