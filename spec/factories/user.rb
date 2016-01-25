FactoryGirl.define do
  factory :user do
    email "test@test.ru"
    password "secret"
    password_confirmation "secret"
  end
end
