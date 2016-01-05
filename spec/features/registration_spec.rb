require "rails_helper"

describe "registrations" do
  it "can be registered" do
    visit root_path
    first(:link, "Регистрация").click

    fill_in "user_email", with: "test@test.ru"
    fill_in "user_password", with: "secret"
    fill_in "user_password_confirmation", with: "secret"
    click_button "Зарегистрироваться"

    expect(page).to have_content "Выйти"
  end
end
