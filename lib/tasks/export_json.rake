namespace :json do
  desc "Export all data to JSON files"
  task :export => :environment do
    db = {
            description: "This is an export of satnegirji.org database",
            language: Language::LANGUAGES,
            word_class: Language::WordClass::WORD_CLASS,
            words: Word.all.map { |x| { id: x.id, body: x.body, keyword: x.keyword, language: x.language_id, word_class: x.word_class_id } },
            translations: Translation.all.map { |x| { id: x.id, original: x.original_id, translation: x.translation_id } },
          }



    puts db.to_json
  end



end
