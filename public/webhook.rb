require 'json'
require 'open-uri'
require 'net/http'

token = ENV["BOT"]

telegram = JSON.load(open("https://api.telegram.org/bot#{token}/getupdates"))

if telegram["ok"]
  chat_id = telegram["result"][0]["message"]["chat"]["id"]
  update_id = telegram["result"][0]["message"]["update_id"].to_i + 1
  message = telegram["result"][0]["message"]["text"]

  text = "Hello!"
  JSON.load(open("https://api.telegram.org/bot#{token}/sendMessage?chat_id=#{chat_id}&text=#{text}"))
end
