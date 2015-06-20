Fabricator(:review) do
  body { Faker::Lorem.paragraph }
  rating { rand(5.0) }
end