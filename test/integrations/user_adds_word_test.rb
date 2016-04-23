require 'test_helper'

class UserAddWordSpec < ActionDispatch::IntegrationTest
  def valid_parameters_for_word
    {
      body: "beana",
      language_id: Language.find_by_code("northern_sami"),
      word_class_id: Language::WordClass.find_by_code("undefined")
    }
  end

  it "should create a word" do
    get new_word_path
    assert_response :success
    post words_path, params: { word: valid_parameters_for_word }
    follow_redirect!
    path.must_equal word_path( assigns(:word) )
  end
end

