require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
  # put these into fixture
  def create_default_user
    User.create(email: "joe@example.com", password: "example")
  end
  def create_defaults(user = create_default_user)
    thread1 = Discussion.create_thread( "Example", user )
    thread2 = Discussion.create_thread( "Jedi Temple", user )

    thread1.replies.create( body: "This is an example", user: user )
    thread1.replies.create( body: "Gasp! Yet another example", user: user )
    thread2.replies.create( body: "Anyone knows where the Jedi Temple is?", user: user )
    thread2.replies.create( body: "Nevermind, I found it", user: user )
    [thread1, thread2]
  end

  test "pinned discussion can only be a topic of a thread" do
    user = create_default_user
    thread1, thread2 = create_defaults(user)
    reply = thread1.replies.first
    reply.pinned = true
    assert_equal reply.pinned, false
    thread1.pinned = true
    assert_equal thread1.pinned, true
  end

  test "pinned discussions appread first in discussion topic list" do
    user = create_default_user
    Discussion.create_thread( "Unpinned topic 1", user )
    thread_first = Discussion.create_thread( "This should be first", user )
    thread_second = Discussion.create_thread( "This should be second", user )
    Discussion.create_thread( "Unpinned topic 2", user )
    thread_first.pinned = true
    thread_first.save!
    thread_second.pinned = true
    thread_second.save!
    assert_equal Discussion.topics.map {|x| x.title }.first, "This should be first"
    assert_equal Discussion.topics.map {|x| x.title }.second, "This should be second"
  end

  test "hidden discussions should not appead on discussion topic list" do
    user = create_default_user
    Discussion.create_thread( "Random topic 1", user )
    Discussion.create_thread( "Random topic 2", user )
    hidden_thread = Discussion.create_thread( "Hidden", user )
    hidden_thread.hidden = true
    hidden_thread.save
    assert_equal Discussion.topics.map {|x| x.title }, ["Random topic 1", "Random topic 2"]
  end

  test "discussion without a parent makes it a discussion thread" do
    user = create_default_user
    discussion = Discussion.new( title: "title", user: user, parent_id: nil)
    assert discussion.thread?, true
    reply = Discussion.create_reply("reply", user, discussion)
    assert reply.thread?, false
  end
end
