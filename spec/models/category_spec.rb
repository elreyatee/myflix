require 'spec_helper'

describe Category do 
  it "saves itself" do
    category = Category.new(name: "Action")
    category.save
    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    comedies = Category.create(name: "Comedies")
    south_park = Video.create(title: "South Park", description: "Funny video!", category: comedies)
    futurama = Video.create(title: "Futurama", description: "Space travel!", category: comedies)
    expect(comedies.videos).to include(futurama, south_park)
  end

  it "does not save without a name" do
    category = Category.create
    expect(Category.count).to eq(0)
  end