class TranslationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @search_words_path = search_words_path
    @translation = Translation.new
  end

  def index
    @translations = Translation.most_recent.order(created_at: :desc)
  end

  def create
    if @translation = Translation.create_two_way_translation(translation_params)
      redirect_to translation_path(@translation)
    else
      render 'new'
    end
  end

  def show
    @translation = Translation.find(params[:id])
  end

  private

  def translation_params(creator_id = current_user.id)
    params.require(:translation).permit( :original_id, :translation_id ).merge( creator_id: creator_id)
  end

end
