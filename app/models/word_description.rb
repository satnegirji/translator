class WordDescription < ApplicationRecord

  validates :body, presence: true
  validates :language_id, presence: true
  validates :word_id, presence: true

  validates :word_id, uniqueness: { scope: :language_id, message: "Only one description per language"}

  belongs_to :word

  def language
    Language.find( self[:language_id] )
  end
end
