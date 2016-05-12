class TranslationsController < ApplicationController
  before_action :authenticate_user!

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

  def translation_params(owner_id = current_user.id)
    params.require(:translation).permit( :original_id, :translation_id ).merge( owner_id: owner_id)
  end

end
