require "rails_helper"

RSpec.describe Card, :type => :model do
  card = Card.new(original_text: "house", translated_text: "дом", transcription: "[haʊs]")
  
  it 'will return false' do
    expect(card.check_translation("house")).to be true
  end

  it 'will return true' do
    expect(card.check_translation("Дом")).to be false
  end
end
