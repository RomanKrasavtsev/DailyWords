require 'telegram/bot'

task :telegram => :environment do
  token = ENV["BOT"]
  users = User.where("telegram_id IS NOT NULL")

  users.each do |user|
    card = user.cards.review.first

    Telegram::Bot::Client.run(token) do |bot|
      bot.api.sendMessage(chat_id: user.telegram_id, text: "#{card.original_text} #{card.transcription} - #{card.translated_text}")
    end
  end
end
