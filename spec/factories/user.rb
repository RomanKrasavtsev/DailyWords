FactoryGirl.define do
  factory :user do
    email "test@test.ru"
    password "secret"
    password_confirmation "secret"
    time_from "10:00"
    time_to "18:00"
    telegram_id 1
  end
end
