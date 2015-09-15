Fabricator(:user) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password { Faker::Internet.password(7) }
  admin false
end

Fabricator(:admin, from: :user) do 
  admin true
end
