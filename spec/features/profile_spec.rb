require "rails_helper"

describe "settings" do
  before(:each) do
    @user = create(:user)

    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: "secret"
    click_button "Войти"
    visit settings_path
  end

  it "can be changed password" do
    click_link "Изменить"
    fill_in "user_new_password", with: "secret1"
    fill_in "user_new_password_confirmation", with: "secret1"
    fill_in "user_password", with: "secret"
    click_button "Изменить"

    expect(page).to have_content "Ваши данные успешно изменены"
    click_link "Выйти"

    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: "secret1"
    click_button "Войти"
    expect(page).to have_content "Выйти"
  end

  it "cannot be changed password (wrong password)" do
    click_link "Изменить"
    fill_in "user_new_password", with: "secret"
    fill_in "user_new_password_confirmation", with: "secret"
    fill_in "user_password", with: "secret1"
    click_button "Изменить"

    expect(page).to have_content "Неверно указан текущий пароль!"
  end

  it "cannot be changed password (bad password confirmation)" do
    click_link "Изменить"
    fill_in "user_new_password", with: "secret"
    fill_in "user_new_password_confirmation", with: "secret1"
    fill_in "user_password", with: "secret"
    click_button "Изменить"

    expect(page).to have_content "Подтверждение и пароль должны совпадать!"
  end

  it "can be changed email" do
    click_link "test@test.ru"
    fill_in "user_email", with: "test1@test.ru"
    fill_in "user_password", with: "secret"
    click_button "Изменить"
    expect(page).to have_content "Ваши данные успешно изменены"

    first(:link, "Выйти").click

    visit login_path
    fill_in "email", with: "test1@test.ru"
    fill_in "password", with: "secret"
    click_button "Войти"
    expect(page).to have_content "Выйти"
  end

  it "cannot be changed email (bad password)" do
    click_link "test@test.ru"
    fill_in "user_email", with: "test1@test.ru"
    fill_in "user_password", with: "secret2"
    click_button "Изменить"
    expect(page).to have_content "Неверно указан текущий пароль!"
  end

  it "can be changed telegram" do
  end

  it "cannot be changed telegram (bad password)" do
  end
end
