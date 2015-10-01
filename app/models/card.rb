class Card < ActiveRecord::Base
  validates :review_date, :original_text, :translated_text, :transcription, presence: true
  validates :original_text, uniqueness: true
  validate :original_text_equal_to_translated_text

  def original_text_equal_to_translated_text
    if original_text.downcase == translated_text.downcase
      errors.add(:original_text, "Слово и Перевод не должны быть одинаковые!")
    end
  end
end
