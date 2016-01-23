require 'telegram/bot'

token = ENV["BOT"]

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.sendMessage(chat_id: message.chat.id, text: "Привет, #{message.from.first_name}! Ваш ID: #{message.from.id}")
    when '/help'
      bot.api.sendMessage(chat_id: message.chat.id, text:
        "@DailyWordsRuBot - это бот сайта http://dailywords.ru,"\
        " который поможет Вам выучить иностранные слова,"\
        " горячие клавиши операционной системы или приложений,"\
        " языки программирования и т.д.\n\n"\
        "Основные команды:\n"\
        "/help - показать справку\n"\
        "/id - показать Ваш ID\n"\
      )
    when '/id'
      bot.api.sendMessage(chat_id: message.from.id, text: "Ваш ID: #{message.from.id}")
    else
      bot.api.sendMessage(chat_id: message.chat.id, text: "Список доступных команд можно получить набрав /help")
    end
  end
end
