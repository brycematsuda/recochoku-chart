require 'chart'
require 'rank'

RSpec.describe Rank do
  before :all do
    @chart = Chart.new
    @rank = @chart.rankings.first
  end

  it "has a rank number" do
    expect(@rank.num).to be_truthy
  end

  it "has a title" do
    expect(@rank.title).to be_truthy
  end

  it "has an artist" do
    expect(@rank.artist).to be_truthy
  end
end