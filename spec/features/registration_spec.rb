require "rails_helper"

describe "registration" do
  it "can be registered" do
    visit root_path
    first(:link, "Регистрация").click

    fill_in "user_email", with: "test@test.ru"
    fill_in "user_password", with: "secret"
    fill_in "user_password_confirmation", with: "secret"
    click_button "Зарегистрироваться"

    expect(page).to have_content "Выйти"
  end

  it "cannot be registered (email exists)" do
    visit root_path
    first(:link, "Регистрация").click

    fill_in "user_email", with: "test@test.ru"
    fill_in "user_password", with: "secret"
    fill_in "user_password_confirmation", with: "secret"
    click_button "Зарегистрироваться"
    expect(page).to have_content "Выйти"

    first(:link, "Выйти").click

    visit root_path
    first(:link, "Регистрация").click
    fill_in "user_email", with: "test@test.ru"
    fill_in "user_password", with: "secret"
    fill_in "user_password_confirmation", with: "secret"
    click_button "Зарегистрироваться"
    expect(page).to have_content "Email уже зарегистрирован!"
  end

  it "cannot be registered (bad password confirmation)" do
    visit root_path
    first(:link, "Регистрация").click

    fill_in "user_email", with: "test@test.ru"
    fill_in "user_password", with: "secret"
    fill_in "user_password_confirmation", with: "secret1"
    click_button "Зарегистрироваться"
    expect(page).to have_content "Подтверждение и пароль должны совпадать!"
  end
end
