require "rails_helper"

RSpec.describe Card, type: :model do
  it "validates with erorrs" do
    card = Card.new(
      original_text: "Дом",
      translated_text: "дОм",
      transcription: "[haʊs]"
    )

    card.valid?
    expect(card.errors).to be_present
  end

  let(:card) do
    Card.new(
      original_text: "house",
      translated_text: "дом",
      transcription: "[haʊs]"
    )
  end

  it "validates without errors" do
    card.valid?
    expect(card.errors).to be_blank
  end

  it "checks translation and will return true" do
    expect(card.check_translation("house")).to be true
  end

  it "checks translation and will return false" do
    expect(card.check_translation("Дом")).to be false
  end
end
