require 'telegram/bot'

task :telegram => :environment do
  token = ENV["BOT"]
  time = Time.now.utc.strftime("%H:%M")
  users = User.where("telegram_id IS NOT NULL AND telegram_id != 0 AND time_from <= '#{time}' AND time_to >= '#{time}'")

  users.each do |user|
    card = user.cards.review.first

    if card.present?
	    Telegram::Bot::Client.run(token) do |bot|
	      bot.api.sendMessage(chat_id: user.telegram_id, text: "#{card.original_text} - #{card.translated_text}")
	    end
      card.update_review_date
	  end
  end
end
