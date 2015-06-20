Fabricator(:video) do
  title { Faker::Name.title }
  description { Faker::Lorem.words(5).join(" ") }
end
