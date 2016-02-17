FactoryGirl.define do
  factory :card do
    original_text "house [haʊs]"
    translated_text "дом"

    trait :expired do
      review_date (-3.day.since)
    end
  end
end
