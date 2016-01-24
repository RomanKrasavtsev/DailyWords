class Card < ActiveRecord::Base
  belongs_to :users

  before_validation :ensure_review_date_has_a_value
  validates :original_text, :translated_text,
            :transcription, :user_id, presence: true
  validates :original_text, uniqueness: true
  validate :original_text_equal_to_translated_text

  scope :expired, -> { where("review_date <= ?", Time.zone.today) }
  scope :review, -> { expired.offset(rand(expired.count)) }

  def original_text_equal_to_translated_text
    original_text.strip!
    translated_text.strip!

    if original_text.mb_chars.downcase == translated_text.mb_chars.downcase
      errors.add(:original_text)
    end
  end

  def check_translation(entered_text)
    original_text.strip!
    entered_text.strip!

    if original_text.mb_chars.downcase == entered_text.mb_chars.downcase
      update_review_date
      true
    else
      false
    end
  end

  def update_review_date
    update(review_date: 3.days.since)
  end

  protected

  def ensure_review_date_has_a_value
    self.review_date ||= 3.days.since
  end
end
