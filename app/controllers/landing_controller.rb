class LandingController < ApplicationController
  skip_before_action :require_login
  layout "landing"

  def index
    redirect_to new_review_path if current_user
  end
end
