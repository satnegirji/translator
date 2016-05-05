class WordsController < ApplicationController
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
    keyword = Language::Accent.strip(params[:keyword])
    results = Word.where("keyword LIKE ?", "#{keyword}%").limit(10)
    thejson = {

    }
    thejson["suggestions"] = results.map { |w| {"value" => "#{w.body} (#{w.language_id})", "data" => { "id" => w.id, "language_id" => w.language_id, "word_class_id" => w.word_class_id }}}

    # "value": "United Arab Emirates", "data": "AE" },
    #    { "value": "United Kingdom",       "data": "UK" },
    #    { "value": "United States",        "data": "US" }
    render json: thejson
  end

  private

  def word_params
    params.require(:word).permit(:body, :language_id, :word_class_id)
  end
end
