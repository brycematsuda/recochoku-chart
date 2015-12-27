require 'rank'

RSpec.describe Rank do
  before :all do
    @rank = Rank.new("Test Title", "Test Artist", "5")
  end

  it "has a rank number" do
    expect(@rank.num).to be_truthy
    expect(@rank.num).to eq("5")
  end

  it "has a title" do
    expect(@rank.title).to be_truthy
    expect(@rank.title).to eq("Test Title")
  end

  it "has an artist" do
    expect(@rank.artist).to be_truthy
    expect(@rank.artist).to eq("Test Artist")
  end
end