class ReviewsController < ApplicationController
  before_action :set_quantity

  # get a card for review
  def new
    @card = current_user.cards.review.first
  end

  # check translation
  def create
    card = current_user.cards.find(review_params[:card_id])

    if card.check_translation(review_params[:entered_text])
      flash[:true] = "#{t(:true_html)}"\
                     "#{t(:the_right_answer)} #{card.original_text}<br>"
    else
      flash[:false] = "#{t(:false_html)}"\
                      "#{t(:the_right_answer)} #{card.original_text}<br>"\
                      "#{t(:your_answer)} #{review_params[:entered_text]}"
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def set_quantity
    @quantity = current_user.cards.count
  end

  def review_params
    params.require(:review).permit(
      :card_id,
      :entered_text
    )
  end
end
