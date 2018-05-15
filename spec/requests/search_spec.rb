require 'rails_helper'

RSpec.describe "search form", :type => :request, js: true do
  it "display result after click search form" do
    visit newspapers_path
    user_1 = User.create!(first_name: "Hoang", last_name: "Dinh", email: "dhoanghvs@gmail.com", password: "1234567")
    user_2 = User.create!(first_name: "Huy", last_name: "Dinh", email: "dhuy@gmail.com", password: "1234567")

    vietnam = Newspaper.create!(title: "VietNam", content: "Lorem", user_id: user_1.id, role: "user")
    laos = Newspaper.create!(title: "Laos", content: "Lorem1", user_id: user_2.id, role: "user")
    expect(page).to have_button("Go!")
    expect(page).to have_content("Search")

    fill_in "search", with: "VietNam"
    click_button "Go!"
    expect(page).to have_content(vietnam.title)
    expect(page).not_to have_content(laos.title)
  end
end