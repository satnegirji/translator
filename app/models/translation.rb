class Translation < ApplicationRecord
  belongs_to :original, class_name: "Word", foreign_key: "original_id"
  belongs_to :translation, class_name: "Word", foreign_key: "translation_id"

  belongs_to :owner, class_name: "User", foreign_key: "owner_id"
  scope :most_recent, ->(limit = 15) { order(created_at: :desc).limit(limit) }

end
