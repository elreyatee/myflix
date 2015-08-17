require 'spec_helper'

feature "see video show page" do  
  scenario "user adds videos to the queue" do  
    action = Fabricate(:category, name: "Action")
    raid = Fabricate(:video, title: "The Raid", category: action)
    raid2 = Fabricate(:video, title: "The Raid 2", category: action)
    raid3 = Fabricate(:video, title: "The Raid 3", category: action)

    sign_in
    
    add_video_to_queue(raid)
    expect_video_to_be_in_queue(raid)
    visit video_path(raid)
    expect_link_not_to_be_seen("+ My Queue")

    add_video_to_queue(raid2)
    add_video_to_queue(raid3)

    set_video_position(raid, 3)
    set_video_position(raid2, 1)
    set_video_position(raid3, 2)
    update_queue

    expect(find("input[data-video-id='#{raid2.id}']").value).to eq("1")
    expect(find("input[data-video-id='#{raid3.id}']").value).to eq("2")
    expect(find("input[data-video-id='#{raid.id}']").value).to eq("3")
  end
end

def add_video_to_queue(video)
  click_video_on_home_page(video)
  click_link "+ My Queue"
end

def expect_video_to_be_in_queue(video)
  expect(page).to have_content(video.title)
end

def expect_link_to_be_seen(link)
  expect(page).to have_content(link.title)
end

def expect_link_not_to_be_seen(link)
  expect(page).to_not have_content(link)
end

def update_queue
  click_button "Update Instant Queue"
end

def add_video_to_queue(video)
  visit home_path
  find("a[href='/videos/#{video.id}']").click
  click_link "+ My Queue"
end

def set_video_position(video, position)
  find("input[data-video-id='#{video.id}']").set(position)
end