class Word < ApplicationRecord
  validates :body, presence: true
  validates :keyword, presence: true
  validates :language_id, presence: true
  validates :owner, presence: true
  has_many :translations, foreign_key: "original_id"

  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  before_validation :set_accent

  scope :most_recent, ->(limit = 15) { order(created_at: :desc).limit(limit) }

  def self.search(arg)
    keyword = Language::Accent.strip(arg)
    Word.where("keyword LIKE ?", "#{keyword}%").limit(10)
  end

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

