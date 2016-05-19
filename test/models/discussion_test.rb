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
    answer.pin!
    assert answer.pinned == false
    thread1.pin!
    assert thread1.pinned == false
  end

  test "pinned discussions appread first in discussion topic list" do
    #TODO
  end
end
