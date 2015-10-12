class ReviewController < ApplicationController
  def new
    @card = Card.expired.first
  end

  def create
    card = Card.find(review_params[:id])

    if card.equal_to_entered_text?(review_params[:entered_text])
      flash[:true] = "Верно!"
    else
      flash[:false] = "Не верно!<br>
                       Правильный ответ: #{card.original_text}<br>
                       Ваш ответ: #{review_params[:entered_text]}"
    end

    redirect_to :back
  end

  private

  def review_params
    params.require(:review).permit(
      :id,
      :entered_text
    )
  end
end
