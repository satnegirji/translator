class Word < ApplicationRecord
  validates :body, presence: true
  validates :keyword, presence: true
  validates :language_id, presence: true
  has_many :translations, foreign_key: "original_id"

  before_validation :set_accent

  def set_accent
    self[:keyword] = Language::Accent.strip(self[:body] || "")
  end

  def language
    Language.find( self[:language_id] )
  end

  def word_class
    Language::WordClass.find(self[:word_class_id])
  end
end

