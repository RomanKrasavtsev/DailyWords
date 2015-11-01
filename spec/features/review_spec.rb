require "rails_helper"

feature "review" do
  context "can start" do
    before(:each) do
      create(:card, :expired)
    end

    it "can check card" do
      visit root_path
      fill_in "review_entered_text", with: "House"
      click_button "Проверить"
      expect(page).to have_content "Верно!"
    end
  end
end
