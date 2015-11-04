require "rails_helper"

describe Card do
  before(:each) do
    @user = create(:user)
  end

  it "validates with erorrs" do
    card = Card.new(
      original_text: "Дом",
      translated_text: "дОм",
      transcription: "[haʊs]",
      user_id: @user.id
    )

    card.valid?
    expect(card.errors).to be_present
  end

  context "when checked translation" do
    let(:card) do
      Card.new(
        original_text: "house",
        translated_text: "дом",
        transcription: "[haʊs]",
        user_id: @user.id
      )
    end

    it "validates without errors" do
      card.valid?
      expect(card.errors).to be_blank
    end

    it "will return true" do
      expect(card.check_translation("house")).to be true
    end

    it "will return false" do
      expect(card.check_translation("Дом")).to be false
    end
  end
end
