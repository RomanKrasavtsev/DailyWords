class ReviewsController < ApplicationController
  def new
    @title = "Проверка"
    @card = current_user.cards.review.first
    @quantity = current_user.cards.count
  end

  def create
    card = current_user.cards.find(review_params[:card_id])

    if card.check_translation(review_params[:entered_text])
      flash[:true] = "Верно!<br>
        Правильный ответ: #{card.original_text} #{card.transcription}<br>"
    else
      flash[:false] = "Не верно!<br>
        Правильный ответ: #{card.original_text} #{card.transcription}<br>
        Ваш ответ: #{review_params[:entered_text]}"
    end

    redirect_to :back
  end

  private

  def review_params
    params.require(:review).permit(
      :card_id,
      :entered_text
    )
  end
end
