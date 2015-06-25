require 'spec_helper'

feature "the sign in process" do  
  background do 
    User.create(name: "Aaron", email: "aaron@temple.com", password: "password")
  end

  scenario "signing in with correct credentials" do  
    visit '/sign_in'
    within "fieldset#sign_in" do  
      fill_in "Email", with: "aaron@temple.com"
      fill_in "Password", with: "password"
    end
    click_button "Sign in"
    expect(page).to have_content("You are signed in.")
  end

  scenario "signing in with incorrect credentials" do  
    visit '/sign_in'
    within "fieldset#sign_in" do  
      fill_in "Email", with: "aaron@temple.com"
      fill_in "Password", with: "wrong"
    end
    click_button "Sign in"
    expect(page).to have_content("Invalid email or password.")
  end 
end