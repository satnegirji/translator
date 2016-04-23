require "language"

Word.delete_all
Translation.delete_all
beana = Word.create!( id: 0, body: "beana", keyword: "beana", language_id: Language.find_by_code("northern_sami"))
dog = Word.create!( id: 1, body: "dog", keyword: "dog", language_id: Language.find_by_code("english"))
koira = Word.create!( id: 2, body: "koira", keyword: "koira", language_id: Language.find_by_code("finnish"))
Word.create!( id: 3, body: "begin", keyword: "begin", language_id: Language.find_by_code("english"))
Word.create!( id: 4, body: "beduiini", keyword: "beduiini", language_id: Language.find_by_code("finnish"))
Translation.create!(id: 0, original_id: beana.id, translation_id: dog.id)
Translation.create!(id: 1, original_id: dog.id, translation_id: beana.id)
Translation.create!(id: 2, original_id: beana.id, translation_id: koira.id)
Translation.create!(id: 3, original_id: koira.id, translation_id: beana.id)
puts "Words: #{Word.count}"
puts "Translations: #{Translation.count}"
