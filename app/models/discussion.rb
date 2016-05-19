class Discussion < ApplicationRecord

  has_many :answers, class_name: "Discussion", foreign_key: "parent_id"

  belongs_to :user

  scope :not_hidden, -> { where(hidden: false)}
  scope :topics, -> { where( parent_id: nil ).order( pinned: :desc).order(:updated_at).not_hidden }
  scope :from_thread, -> (parent_id) { where(parent_id: parent_id).not_hidden }

  def pinned=(value)
    # if discussion thread is topic, it can be pinned up
    unless self[:parent_id]
      self[:pinned] = value
      true
    else
      false
    end
  end

  def self.create_thread(topic, user)
    create( title: topic, user: user, parent_id: nil, body: "" )
  end

  def is_thread?
    self[:parent_id] == nil
  end
end
