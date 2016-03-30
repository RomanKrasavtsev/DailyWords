require 'json'
require 'open-uri'
require 'net/http'

task :telegram => :environment do
  token = ENV["BOT"]
  time = Time.now.utc.strftime("%H:%M")
  users = User.where("telegram_id IS NOT NULL AND telegram_id != 0 AND time_from <= '#{time}' AND time_to >= '#{time}'")

  users.each do |user|
    card = user.cards.review.first
    answer = "#{card.original_text} - #{card.translated_text}"

    if card.present?
      JSON.load(open("https://api.telegram.org/bot#{token}/sendMessage?chat_id=#{user.telegram_id}&text=#{answer}"))

      card.update_review_date
      card.number_of_sendings += 1
      card.save
	  end
  end
end
