FactoryGirl.define do
  factory :card do
    original_text "house"
    translated_text "дом"
    transcription "[haʊs]"

    trait :expired do
      review_date (-3.day.since)
    end
  end
end
