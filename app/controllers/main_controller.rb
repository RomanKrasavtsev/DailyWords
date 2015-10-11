class MainController < ApplicationController
  def index
    @card = Card.expired

    if @card
      render "main/index"
    else
      render "cards/index"
      # На сегодня нет слов для обучения.<br>
      # Обязательно возвращайтесь завтра!
    end
  end

  def check
    parameters = main_params
    card = Card.find(parameters[:id])

    if card.equal?(parameters[:entered_text])
      card.update(review_date: 3.days.since)
      flash[:true] = "Верно!"
    else
      flash[:false] = "Не верно!<br>
                       Правильный ответ: #{card.original_text}<br>
                       Ваш ответ: #{parameters[:entered_text]}"
    end

    redirect_to :back
  end

  private

  def main_params
    params.require(:review).permit(
      :id,
      :entered_text
    )
  end
end
