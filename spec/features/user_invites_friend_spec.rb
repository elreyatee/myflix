require 'spec_helper'

feature "User invites a friend" do 
  scenario "user successfully invites friend and invitation is accepted" do 
    aaron = Fabricate(:user)
    sign_in(aaron)

    invite_a_friend
    friend_accepts_invitation
    friend_signs_in
    friend_should_follow(aaron)
    inviter_should_follow_friend(aaron)
    clear_email
  end

  def invite_a_friend
    click_link "Invite a Friend"
    fill_in "Friend's Name", with: "Tanisha"
    fill_in "Friend's Email Address", with: "tanisha@example.com"
    fill_in "Invitation Message", with: "Hello, please join MyFlix!"
    click_button "Send Invitation"
    sign_out
  end

  def friend_accepts_invitation
    open_email("tanisha@example.com")
    current_email.click_link "Accept this invitation"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "Tanisha Blanchard"
    click_button "Sign Up"
  end

  def friend_signs_in
    fill_in "Email", with: "tanisha@example.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
  end

  def friend_should_follow(user)
    click_link "People"
    expect(page).to have_content user.name
    sign_out
  end

  def inviter_should_follow_friend(user)
    sign_in(user)
    click_link "People"
    expect(page).to have_content "Tanisha Blanchard"
  end
end 