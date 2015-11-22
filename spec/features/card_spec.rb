require "rails_helper"

describe "Cards" do
  before(:each) do
    @user = create(:user)
    @card = create(:card, :expired, user_id: @user.id)

    visit login_path
    fill_in "email", with: @user.email
    fill_in "password", with: "secret"
    click_button "Войти"
  end

  it "can be added" do
    visit new_card_path

    fill_in "card_original_text", with: "mother"
    fill_in "card_translated_text", with: "мама"
    fill_in "card_transcription", with: "[ˈmʌðə]"

    click_button "Добавить"
    expect(page).to have_content "mother"
  end

  it "can be edited" do
    visit cards_path
    click_button "#{@card.id}"
    click_link "Редактировать"

    fill_in "card_original_text", with: "mother"
    fill_in "card_translated_text", with: "мама"
    fill_in "card_transcription", with: "[ˈmʌðə]"
    click_button "Обновить"
    expect(page).to have_content "mother"
  end

  it "can be deleted", js: true do
    visit cards_path
    click_button "#{@card.id}"
    click_link "Удалить"
    page.driver.browser.switch_to.alert.accept
    visit cards_path
    expect(page).to have_no_content "mother"
  end
end
