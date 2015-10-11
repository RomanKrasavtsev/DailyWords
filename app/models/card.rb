class Card < ActiveRecord::Base
  before_validation :ensure_review_date_has_a_value
  validates :original_text, :translated_text, :transcription, presence: true
  validates :original_text, uniqueness: true
  validate :original_text_equal_to_translated_text

  scope :expired, -> {
    where("review_date <= '#{Time.zone.today}'").order("random()").first
  }

  def original_text_equal_to_translated_text
    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add("Слово и Перевод", "не должны быть одинаковые!")
    end
  end

  protected

  def ensure_review_date_has_a_value
    if self.review_date.nil?
      self.review_date = 3.days.since
    end
  end
end
