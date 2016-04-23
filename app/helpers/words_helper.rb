module WordsHelper
  def languages_for_select
    Language::LANGUAGES.map do |key, value|
      [ value, key ]
    end
  end

  def word_classes_for_select
    Language::WordClass::WORD_CLASS.map do |key, value|
      [ value, key ]
    end
  end
end
