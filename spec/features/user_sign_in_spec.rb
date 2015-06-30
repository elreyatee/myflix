require 'spec_helper'

feature "the sign in process" do  
  given(:aaron) { Fabricate(:user, email: "aaron@temple.com", password: "password") }

  scenario "signing in with correct credentials" do  
    sign_in(aaron)
    expect(page).to have_content("You are signed in.")
  end

  scenario "signing in with incorrect credentials" do  
    visit sign_in_path
    fill_in "Email", with: aaron.email
    fill_in "Password", with: "wrong"
    click_button "Sign in"
    expect(page).to have_content("Invalid email or password.")
  end 
end