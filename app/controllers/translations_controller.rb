class TranslationsController < ApplicationController
  def new
    @search_words_path = search_words_path
    @translation = Translation.new
  end

  def index
    @translations = Translation.all.order(created_at: :desc)
  end

  def create
    if @translation = Translation.create(translation_params)
      redirect_to translation_path(@translation)
    else
      render 'new'
    end
  end

  def show
    @translation = Translation.find(params[:id])
  end

  private

  def translation_params
    params.require(:translation).permit( :original_id, :translation_id )
  end

end
