require "rails_helper"
require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

describe "review" do
  before(:each) do
    @user = create(:user)
    create(:card, :expired, user_id: @user.id)

    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: "secret"
    click_button "Войти"
  end

  it "will be right", js: true do
    visit root_path
    fill_in "review_entered_text", with: "house"
    click_button "Проверить"
    expect(page).to have_content "Верно!"
  end

  it "will be wrong", js: true do
    visit root_path
    fill_in "review_entered_text", with: "Haus"
    click_button "Проверить"
    expect(page).to have_content "Не верно!"
  end
end
