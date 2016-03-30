require 'json'
require 'open-uri'
require 'net/http'

class TelegramController < ApplicationController
  skip_before_action :require_login
  skip_before_action :verify_authenticity_token

  def index
    token = ENV["BOT"]
    text = params[:message][:text]
    chat_id = params[:message][:chat][:id]

    case text
    when "/start"
      answer = "Привет, #{params[:message][:from][:first_name]}! Ваш ID: #{chat_id}"
    when "/id"
      answer = "Ваш ID: #{chat_id}"
    when "/help"
      answer = "@DailyWordsRuBot - это бот сайта http://dailywords.ru,"\
        " который поможет Вам выучить иностранные слова,"\
        " горячие клавиши операционной системы или приложений,"\
        " языки программирования и т.д.\n"\
    else
      answer = "Основные команды:\n"\
        "/help - показать справку\n"\
        "/id - показать Ваш ID\n"
    end

    url = URI.parse(URI.encode("https://api.telegram.org/bot#{token}/sendMessage?chat_id=#{chat_id}&text=#{answer}"))
    JSON.load(open(url))
  end

  private

  def telegram_params
    params.permit(
      :update_id,
      message: [
        :message_id,
        :date,
        :text,
        from: [
          :id,
          :first_name,
          :last_name,
          :username
        ],
        chat: [
          :id,
          :first_name,
          :last_name,
          :username,
          :type
        ]
      ],
      telegram: [
        :update_id,
        message: [
          :message_id,
          from: [
            :id,
            :first_name,
            :last_name,
            :username
          ],
          chat: [
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
