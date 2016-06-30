require 'test_helper'

class WordDescriptionTest < ActiveSupport::TestCase
  test "uniqueness in scope of language_id" do
    creator = User.create!(email: "test@test.com", password: "jeejeejee")
    word = Word.create!(body: "beana", language_id: 0, creator: creator)
    WordDescription.create( word_id: 0, language_id: 0, body: "original description")
    assert_no_difference 'WordDescription.count' do
      WordDescription.create(word_id: 0, language_id: 0, body: "overriding description")
    end
  end
end
