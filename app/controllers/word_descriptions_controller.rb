class WordDescriptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    word_id = params[:word_id]
    @word = Word.find(word_id)
    @word_description = @word.descriptions.build
  end
end
