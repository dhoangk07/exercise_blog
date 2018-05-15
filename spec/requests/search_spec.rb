require 'rails_helper'

RSpec.describe "search form", :type => :request, js: true do
  it "display result after click search form" do
    title = Faker::Lorem.sentence(1)

    click_link "Search"

    debugger
    fill_in :search, with: title
    click_button 'Search'

    sleep 20

    expect(page).to have_text(title)
    # expect(page).not_to have_text(job2.title)
  end
end