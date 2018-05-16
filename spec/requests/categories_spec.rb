require 'rails_helper'

RSpec.describe "Categories form", :type => :request, js: true do
  it "display categories after newspaper have tag" do
    visit newspapers_path
    user_1 = User.create!(first_name: "Hoang", last_name: "Dinh", email: "dhoanghvs@gmail.com", password: "1234567")
    user_2 = User.create!(first_name: "Huy", last_name: "Dinh", email: "dhuy@gmail.com", password: "1234567")

    vietnam = Newspaper.create!(title: "VietNam", content: "Lorem", user_id: user_1.id, role: "user")
    laos = Newspaper.create!(title: "Laos", content: "Lorem1", user_id: user_2.id, role: "user")
    
    expect(page).to have_content("Categories")
    # expect(page).to have_content("VietNam")

    expect(page).to have_button("Read More")

    

#     click_button "Edit"
#     visit edit_newspaper_path(vietnam.id)
#     tag_1 = Tag.create!(name: "Sport")
#     tagging_1 = Tagging.create!(tag_id: tag_1.id, newspaper_id: vietnam.id)
# sleep 20

#     fill_in "newspaper_tag_list", with: "Sport"
#     click_button "Edit Newspaper"

#     visit newspapers_path
#     expect(page).to have_content("Sport")


  end
end









    # fill_in "search", with: "VietNam"
    # click_button "Go!"
    # expect(page).to have_content(vietnam.title)
    # expect(page).not_to have_content(laos.title)