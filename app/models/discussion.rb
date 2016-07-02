class Discussion < ApplicationRecord

  has_many :replies, class_name: "Discussion", foreign_key: "parent_id"

  belongs_to :user

  scope :not_hidden, -> { where(hidden: false)}
  scope :topics, -> { where( parent_id: nil ).order( pinned: :desc).order(replied_at: :desc).order(updated_at: :desc).not_hidden.includes(:replies) }
  scope :from_thread, -> (parent_id) { where(parent_id: parent_id).not_hidden }

  def last_reply
    if replies.count == 0
      self
    else

      replies.last
    end
  end

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

  def thread?
    self[:parent_id] == nil
  end

  def self.create_reply(body, user, parent_id)
    reply = create( title: "", body: body, user: user, parent_id: parent_id )
    update_replied_at(parent_id)
    reply
  end

  def parent
    if parent_id
      Discussion.find(parent_id)
    else
      nil
    end
  end

  def self.update_replied_at(parent_id)
    if parent = Discussion.find(parent_id)
      parent.update_columns( replied_at: Time.now )
    end
  end
end
