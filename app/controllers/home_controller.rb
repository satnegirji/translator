class HomeController < ApplicationController
  def index
    @latest_words = Word.most_recent
    @latest_translations = Translation.most_recent
  end
end
