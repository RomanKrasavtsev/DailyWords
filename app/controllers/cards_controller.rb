class CardsController < ApplicationController
  def index
    @cards = Card.all.order(original_text: :asc)
  end
end
