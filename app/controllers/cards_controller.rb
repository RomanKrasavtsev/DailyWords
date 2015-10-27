class CardsController < ApplicationController
  before_action :get_id, only: [:update, :edit, :destroy]

  def index
    @cards = Card.order("lower(original_text) ASC").all
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(cards_params)

    if @card.save
      redirect_to cards_path
    else
      render "new"
    end
  end

  def update
    if @card.update(cards_params)
      redirect_to cards_path
    else
      render "edit"
    end
  end

  def destroy
    @card.destroy

    redirect_to cards_path
  end

  private

  def cards_params
    params.require(:card).permit(:review_date,
                                 :original_text,
                                 :translated_text,
                                 :transcription)
  end

  def get_id
    @card = Card.find(params[:id])
  end
end
