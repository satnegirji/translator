require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
  # put these into fixture
  def create_default_user
    User.create(email: "joe@example.com", password: "example")
  end
  def create_defaults(user = create_default_user)
    thread1 = Discussion.create_thread( "Example", user )
    thread2 = Discussion.create_thread( "Jedi Temple", user )

    thread1.answers.create( body: "This is an example", user: user )
    thread1.answers.create( body: "Gasp! Yet another example", user: user )
    thread2.answers.create( body: "Anyone knows where the Jedi Temple is?", user: user )
    thread2.answers.create( body: "Nevermind, I found it", user: user )
    [thread1, thread2]
  end

  test "pinned discussion can only be a topic of a thread" do
    user = create_default_user
    thread1, thread2 = create_defaults(user)
    answer = thread1.answers.first
    answer.pinned = true
    assert_equal answer.pinned, false
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
end
