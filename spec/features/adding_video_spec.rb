require 'spec_helper'

feature "see add a video page" do 
  scenario "admin adds a video" do 
    aaron = Fabricate(:user)
    action = Fabricate(:category, name: "Action")
    video = Fabricate(:video, title: "Raid", category: action, description: "Martial Arts action")
    admin = Fabricate(:admin)
    sign_in(admin)

    visit new_admin_video_path
    fill_in "Title", with: video.title
    select "Action", from: "Category"
    fill_in "Description", with: "video.description"
    click_button "Add Video"
    sign_out

    sign_in(aaron)
    find("a[href='/videos/#{video.id}']").click
    expect(page).to have_content(video.title)
  end
end