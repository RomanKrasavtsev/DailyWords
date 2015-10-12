class Card < ActiveRecord::Base
  before_validation :ensure_review_date_has_a_value
  validates :original_text, :translated_text, :transcription, presence: true
  validates :original_text, uniqueness: true
  validate :original_text_equal_to_translated_text

  scope :expired, -> {
    where("review_date <= '#{Time.zone.today}'").order("random()")
  }

  def original_text_equal_to_translated_text
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add("Слово и Перевод", "не должны быть одинаковые!")
    end
  end

  def equal_to_entered_text?(entered_text)
    if self.original_text.mb_chars.downcase == entered_text.mb_chars.downcase
      self.update(review_date: 3.days.since)
      true
    else
      false
    end
  end

  protected

  def ensure_review_date_has_a_value
    self.review_date ||= 3.day.since
  end
end
