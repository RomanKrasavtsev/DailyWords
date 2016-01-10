require "rails_helper"

describe "session" do
  before(:each) do
    @user = create(:user)

    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: "secret"
    click_button "Войти"
  end

  it "login" do
    expect(page).to have_content "Выйти"
  end

  it "logout" do
    first(:link, "Выйти").click
    expect(page).to have_content "Войти"
  end

  it "login failed" do
    first(:link, "Выйти").click
    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: "secret1"
    click_button "Войти"
    expect(page).to have_content "Неверный логин или пароль!"
  end
end
