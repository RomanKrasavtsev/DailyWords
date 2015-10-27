class ReviewsController < ApplicationController
  def new
    @card = Card.review.first
  end

  def create
    card = Card.find(reviews_params[:card_id])

    if card.check_translation(reviews_params[:entered_text])
      flash[:true] = "Верно!<br>
        Правильный ответ: #{card.original_text} #{card.transcription}<br>"
    else
      flash[:false] = "Не верно!<br>
        Правильный ответ: #{card.original_text} #{card.transcription}<br>
        Ваш ответ: #{reviews_params[:entered_text]}"
    end

    redirect_to :back
  end

  private

  def reviews_params
    params.require(:review).permit(
      :card_id,
      :entered_text
    )
  end
end
