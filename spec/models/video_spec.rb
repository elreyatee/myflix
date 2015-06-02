require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "Superman", description: "Man of Steel")
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    dramas = Category.create(name: "dramas")
    monk = Video.create(title: "Monk", description: "A drama", category: dramas)
    expect(monk.category).to eq(dramas)
  end

  it "does not save a video without a title" do
    video = Video.create(description: "A good video!")
    expect(Video.count).to eq(0)
  end

  it "does not save a video without a description" do
    video = Video.create(title: "Monk")
    expect(Video.count).to eq(0)
  end