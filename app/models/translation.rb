class Translation < ApplicationRecord
  belongs_to :original, class_name: "Word", foreign_key: "original_id"
  belongs_to :translation, class_name: "Word", foreign_key: "translation_id"
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :creator, presence: true
  scope :most_recent, ->(limit = 15) { order(created_at: :desc).limit(limit) }

end
