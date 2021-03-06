class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @latest_words = Word.most_recent
    @latest_translations = Translation.most_recent
  end

  def search
    @words = Word.search(params[:keyword])
    @keyword = params[:keyword]
  end
end
