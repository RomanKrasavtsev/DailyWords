# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Card.create(original_text:"Fine", transcription: "[faɪn]",translated_text: "Сухой (о погоде), хороший, штраф", review_date: '10-10-2015')
Card.create(original_text:"Meet / Met / Met", transcription: "[miːt] / [met] / [met]",translated_text: "Встречать, собираться, видеться", review_date: '10-10-2015')
Card.create(original_text:"Phone", transcription: "[fəʊn]",translated_text: "Телефон, телефонная трубка, звонить по телефону", review_date: '10-10-2015')