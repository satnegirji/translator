class WordDescription < ApplicationRecord

  validates :body, presence: true
  validates :language_id, presence: true
  validates :word_id, presence: true
  validates :creator_id, presence: true

  validates :word_id, uniqueness: { scope: :language_id, message: "Only one description per language"}

  belongs_to :word
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  def language
    Language.find( self[:language_id] )
  end
end
