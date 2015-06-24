def set_current_user
  aaron = Fabricate(:user)
  session[:user_id] = aaron.id
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end