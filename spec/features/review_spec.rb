require "rails_helper"

context "review can be started" do
  before(:each) do
    create(:card, :expired)
    visit root_path
  end

  it "will be right" do
    fill_in "review_entered_text", with: "House"
    click_button "Проверить"
    expect(page).to have_content "Верно!"
  end

  it "will be wrong" do
    fill_in "review_entered_text", with: "Haus"
    click_button "Проверить"
    expect(page).to have_content "Не верно!"
  end
end
