Fabricator(:invitation) do  
  name { Faker::Name.name }
  email { Faker::Internet.email }
  message { Faker::Lorem.words(5).join(" ")  }
end