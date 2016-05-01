class TranslationsController < ApplicationController
  def new
    @search_words_path = search_words_path
    @translation = Translation.new
  end

  def index
    @translations = Translation.all.order(:created_at)
  end

  def create
    translation = translation_params
    original = original_params
    if original.fetch("create_new", "false") != "false"
      original_id = original.fetch("word_id")
    else
      p = original.select { |k,v| k != "word_id"  }.select { |k,v| k != "create_new"  }
      word = Word.create( p )
      original_id = word.id
    end
    if translation.fetch("create_new", "false") != "false"
      translation_id = translation.fetch("word_id")
    else
      p = translation.select { |k,v| k != "word_id"  }.select { |k,v| k != "create_new"  }
      word = Word.create( p )
      translation_id = word.id
    end
    translation = Translation.create!( original_id: original_id, translation_id: translation_id )

    redirect_to translation_path(translation)
  end

  def show
    @translation = Translation.find(params[:id])
  end

  private

  def create_word_from(params)
    Word.create( body: params[:translation_translation])
  end

  def translation_params
    params.require(:translation).permit( permit_params )
  end

  def original_params
    params.require(:original).permit( permit_params )
  end

  def permit_params
    [
      :body, :language_id, :word_class_id, :create_new, :word_id
    ]
  end

  def translation_params_fetch(param)
    translation_params.select { |key| key.to_s.starts_with?("#{param}") }
  end
end
