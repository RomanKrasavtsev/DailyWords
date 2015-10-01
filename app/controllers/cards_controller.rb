class CardsController < ApplicationController
  before_action :get_id, only: [:update, :edit]

  def index
    @cards = Card.all.order(original_text: :asc)
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to cards_path
    else
      render "new"
    end
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      render "edit"
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:review_date,
                                 :original_text,
                                 :translated_text,
                                 :transcription)
  end

  def get_id
    @card = Card.find(params[:id])
  end
end
