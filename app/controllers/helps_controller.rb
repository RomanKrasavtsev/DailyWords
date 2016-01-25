class HelpsController < ApplicationController
  before_action :set_quantity
  def index
  end

  private

  def set_quantity
    @quantity = current_user.cards.count
  end
end
