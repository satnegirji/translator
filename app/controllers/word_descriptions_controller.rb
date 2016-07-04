class WordDescriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @word_description = word.descriptions.build
  end

  def create
    if @word_description = word.descriptions.create(word_description_params)
      redirect_to @word
    else
      render 'new'
    end
  end

  def edit
    @word_description = word.descriptions.find(params[:id])
  end

  def update
    @word_description = word.descriptions.find(params[:id])
    if @word_description.update_attributes(word_description_params)
      flash[:success] = t('words.word_description.form.successfully_updated')
      redirect_to @word
    else
      render 'edit'
    end
  end

  private

  def word
    @word ||= Word.find(params[:word_id])
  end

  def word_description_params
    params.require(:word_description).permit(:body, :language_id)
  end
end
