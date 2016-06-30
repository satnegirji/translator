class WordDescription < ApplicationRecord

  validates :body, presence: true
  validates :language_id, presence: true
  validates :word_id, presence: true

  validates :word_id, uniqueness: { scope: :language_id, message: "Only one description per language"}
end
