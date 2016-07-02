class Translation < ApplicationRecord
  belongs_to :original, class_name: "Word", foreign_key: "original_id"
  belongs_to :translation, class_name: "Word", foreign_key: "translation_id"
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"

  validates :creator, presence: true
  scope :most_recent, ->(limit = 15) { order(created_at: :desc).limit(limit) }


  def self.create_two_way_translation(params)
    original_id = params.fetch(:original_id)
    translation_id = params.fetch(:translation_id)
    creator_id = params.fetch(:creator_id)
    original = create!( creator_id: creator_id, original_id: original_id, translation_id: translation_id)
    translation = create!( creator_id: creator_id, translation_id: original_id, original_id: translation_id)
  end
end
