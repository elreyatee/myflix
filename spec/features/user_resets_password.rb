require 'spec_helper'

feature "User resets password" do
  scenario "user successfully resets the password" do 
    aaron = Fabricate(:user, email: 'aaron@example.com', password: 'old_password')

    visit sign_in_path
    click_link "Forgot Password"
    fill_in "Email", with: aaron.email
    click_button "Send Email"
    open_email(aaron.email)
    current_email.click_link "Reset my password"

    fill_in "New Password", with: "new_password"
    click_button "Reset Password"
    expect(page).to have_content("Your password has been changed. Please sign in.")
    
    #we are now on sign_in page
    fill_in "Email", with: aaron.email
    fill_in "Password", with: "new_password"
    click_button "Sign in"
    expect(page).to have_content("You are signed in.")
  end 
end