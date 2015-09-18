class MainController < ApplicationController
  def index
    @title = "Первый в мире удобный менеджер флеш-карточек. Именно так.".split(" ")
  end
end
