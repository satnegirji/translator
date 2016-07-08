class WordDescriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @word_description = word.descriptions.build
  end

  def create
    params = word_description_params.merge( creator: current_user )
    @word_description = word.descriptions.build(params)
    if @word_description.save
      flash[:success] = t('words.word_description.form.successfully_created')
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

  def destroy
    @word_description = word.descriptions.find(params[:id])
    @word_description.destroy
    flash[:success] = t('words.word_description.form.successfully_deleted')
    redirect_to @word
  end

  private

  def word
    @word ||= Word.find(params[:word_id])
  end

  def word_description_params
    params.require(:word_description).permit(:body, :language_id)
  end
end
