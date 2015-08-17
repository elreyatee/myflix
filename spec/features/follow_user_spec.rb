require 'spec_helper'

feature "User following" do
  scenario "user follows and unfollows another user" do 
    aaron = Fabricate(:user)
    action = Fabricate(:category, name: "Action")
    video = Fabricate(:video, category: action)
    Fabricate(:review, video: video, user: aaron)

    sign_in
    click_video_on_home_page(video)
    click_link aaron.name
    click_button "Follow"
    expect(page).to have_content(aaron.name)

    click_unfollow
    expect(page).to have_content("You are no longer following #{aaron.name}")
  end
end