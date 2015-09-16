require 'spec_helper'

feature "Admin adds a new video" do 
  scenario "Admin successfully adds a video" do 
    aaron = Fabricate(:user)
    action = Fabricate(:category, name: "Action")
    video = Fabricate(:video, title: "Raid", category: action, description: "Martial Arts action")
    admin = Fabricate(:admin)
    sign_in(admin)

    visit new_admin_video_path
    fill_in "Title", with: video.title
    select "Action", from: "Category"
    fill_in "Description", with: "video.description"
    attach_file "Large Cover", "spec/support/uploads/raid_large.jpg"
    attach_file "Small Cover", "spec/support/uploads/raid_small_cover.jpg"
    fill_in "Video URL", with: "http://www.theraid.com"
    click_button "Add Video"
    sign_out

    sign_in(aaron)
    find("a[href='/videos/#{video.id}']").click
    expect(page).to have_content(video.title)
  end
end