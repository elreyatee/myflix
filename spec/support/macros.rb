def sign_in(user = nil)
  user ||= Fabricate(:user)
  visit sign_in_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def sign_out 
  visit sign_out_path
end

def set_referrer
  request.env['HTTP_REFERER'] = "http://localhost:3000"
end

def set_current_user
  aaron = Fabricate(:user)
  session[:user_id] = aaron.id
end

def set_current_admin(admin = nil)
  session[:user_id] = (admin || Fabricate(:admin)).id
end 

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def click_video_on_home_page(video)
  find("a[href='/videos/#{video.id}']").click 
end

def click_unfollow
  find("a[data-method='delete']").click
end 