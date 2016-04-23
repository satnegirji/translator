require 'test_helper'

class CreateTranslationSpec < IntegrationTest
  it "creates a translation when both words do not exist in database" do
    visit '/translations/new'
    fill_in 'original[body]', with: 'Beana'
    fill_in 'translation[body]', with: 'Koira'
    select 'northern_sami', from: 'original[language_id]'
    select 'finnish', from: 'translation[language_id]'
    click_button 'Create translation'
    page.must_have_content "Beana"
    page.must_have_content "Koira"

  end

  it "creates a translation when the original word exists in database" do
    visit '/translations/new'
    fill_in 'original[body]', with: 'Beana'
    fill_in 'translation[body]', with: 'Dog'
    select 'english', from: 'translation[language_id]'
    click_button 'Create translation'
    page.must_have_content "Beana"
    page.must_have_content "Dog"
  end
end
