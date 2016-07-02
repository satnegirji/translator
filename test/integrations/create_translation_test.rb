require 'test_helper'

class CreateTranslationSpec < IntegrationTest

  def login_user(user)
    visit '/users/sign_in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log In'
  end

  def create_defaults
    Capybara.current_driver = :poltergeist
    user = User.create!(email: "email@example.com", password: "testtesttest")
    koira = Word.create!(body: "koira", language_id: 0, creator: user)
    beana = Word.create!(body: "beana", language_id: 1, creator: user)
    dog = Word.create!(body: "dog", language_id: 2, creator: user)
    user
  end

  it "creates a translation when both words do not exist in database" do
    user = create_defaults
    login_user(user)
    visit '/translations/new'
    fill_in 'original_body', with: 'Beana'
    fill_in 'translation_body', with: 'Koira'
    select 'northern_sami', from: 'original_language_id'
    select 'finnish', from: 'translation_language_id'
    click_button 'Create Translation'
    page.must_have_content "koira"
    page.must_have_content "beana"

  end

  it "creates a translation when the original word exists in database" do
    user = create_defaults
    login_user(user)
    visit '/translations/new'
    fill_in 'original_body', with: 'Beana'
    fill_in 'translation_body', with: 'Dog'
    select 'english', from: 'translation_language_id'
    click_button 'Create Translation'
    page.must_have_content "beana"
    page.must_have_content "dog"
  end
end
