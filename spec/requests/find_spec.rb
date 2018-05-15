require 'rails_helper'

RSpec.describe "search form", :type => :request do
  it "display result after click search form" do
    visit "http://localhost:3000/newspapers"

    expect(page).to have_button("Go!")
    expect(page).to have_content("Search")
  end
end