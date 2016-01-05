class CardsController < ApplicationController
  before_action :set_card, only: [:update, :edit, :destroy]
  before_action :quantity, only: [:index, :new, :update, :edit]

  def index
    @cards ||= current_user.cards.order("lower(original_text) ASC").all
  end

  def new
    @card = current_user.cards.new
  end

  def edit
  end

  def create
    @card = current_user.cards.new(card_params)

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
    @card.destroy

    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(
      :review_date,
      :original_text,
      :translated_text,
      :transcription
    )
  end

  def set_card
    @card ||= current_user.cards.find(params[:id])
  end

  def quantity
    @quantity ||= current_user.cards.count
  end
end
