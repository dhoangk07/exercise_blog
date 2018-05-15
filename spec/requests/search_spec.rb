require 'rails_helper'

RSpec.describe "search form", :type => :request do
  it "display result after click search form" do
    visit "http://localhost:3000/newspapers"

    user_1 = User.create!(first_name: "Hoang", last_name: "Dinh", email: "dhoanghvs@gmail.com", password: "1234567", user_id: "1")
    user_2 = User.create!(first_name: "Huy", last_name: "Dinh", email: "dhuy@gmail.com", password: "1234567", user_id: "2")

    VietNam = Newspaper.create!(title: "VietNam", content: "Lorem", user_id: "1", role: "user")
    Laos = Newspaper.create!(title: "Laos", content: "Lorem1", user_id: "2", role: "user")
    expect(page).to have_button("Go!")
    expect(page).to have_content("Search")
    # expect(page).to to respond to has_form?('Search', type: 'text')
    expect(Newspaper.search("VietNam")).to eq([vietnam])
  end
end