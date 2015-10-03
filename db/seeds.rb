# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'nokogiri'
require 'open-uri'

wiki_doc = Nokogiri::HTML(
  open('https://en.wikipedia.org/wiki/Most_common_words_in_English')
)

wiki_words = []
wiki_doc.css('.column ol li').each do |word|
  wiki_words << word.content.downcase
end

words = []
wiki_words.uniq.sort.each do |original_text|
  cambridge_doc = Nokogiri::HTML(
    open("http://dictionary.cambridge.org/dictionary/english-russian/#{original_text}")
  )

  transcription = "[#{cambridge_doc.css('.ipa')[0].text}]"
  translated_text = cambridge_doc.css('.trans')[0].text.strip!

  words << [original_text, transcription, translated_text]
end

words.each do |original_text, transcription, translated_text|
  Card.create(original_text: original_text,
              transcription: transcription,
              translated_text: translated_text,
              review_date: Date.today + 3.days)
end
