class WordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @words = Word.all
  end

  def new
    @word = Word.new
  end

  def show
    @word = Word.find(params[:id])
  end

  def create
    if (@word = Word.create!(word_params))
      redirect_to word_path(@word)
    else
      render 'new'
    end
  end

  def search
    results = Word.search(params[:keyword])
    items = results.map { |w| {"value" => w.body, "data" => { "id" => w.id, "language_id" => w.language_id, "word_class_id" => w.word_class_id }}}
    render json: { "suggestions": items }
  end

  private

  def word_params(creator_id = current_user.id)
    params.require(:word).permit(:body, :language_id, :word_class_id).merge( creator_id: creator_id)
  end
end
