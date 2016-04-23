class Translation < ApplicationRecord
  belongs_to :original, class_name: "Word", foreign_key: "original_id"
  belongs_to :translation, class_name: "Word", foreign_key: "translation_id"


end
