require 'test_helper'

class UserAddWordSpec < IntegrationTest

  def login_user(user)
    visit '/users/sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log In'
  end

  def create_defaults
    Capybara.current_driver = :poltergeist
    user = User.create!(email: "email@example.com", password: "testtesttest")
    user
  end

  def valid_parameters_for_word
    {
      body: "beana",
      language_id: Language.find_by_code("northern_sami"),
      word_class_id: Language::WordClass.find_by_code("undefined")
    }
  end

  it "should create a word" do
    user = create_defaults
    login_user(user)
    visit "/words/new"
    fill_in "word[body]", with: "Beana"
    select "northern_sami", from: "word_language_id"
    click_button "Submit New Word"
    puts page.body
    assert_equal page.has_content?("Beana"), true
  end
end

