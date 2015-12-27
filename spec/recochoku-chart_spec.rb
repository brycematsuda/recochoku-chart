require 'recochoku-chart'
require 'mechanize'
require 'json'

RSpec.describe RecochokuChart do

  before :all do
    @chart = RecochokuChart.new
  end

  context "with no chart specified" do
    it "returns the daily singles chart url" do
      expect(@chart.url).to eq("http://recochoku.jp/ranking/single/daily/")
    end
  end

  it "has rankings" do
    expect(@chart.rankings).to be_truthy
  end

  context "with rankings" do
    it "contains a array of Rank objects" do
      expect(@chart.rankings.class).to eq(Array)
      expect(@chart.rankings.first.class).to eq(RecochokuRank)
    end
  end

  context "daily singles chart specified" do
    it "returns the daily singles chart url" do
      @chart = RecochokuChart.new("single/daily")
      expect(@chart.url).to eq("http://recochoku.jp/ranking/single/daily/")
    end

    it "contains 50 rankings" do
      @chart = RecochokuChart.new("single/daily")
      expect(@chart.rankings.length).to eq(50)
    end
  end

  context "weekly singles chart specified" do
    it "returns the weekly singles chart url" do
      @chart = RecochokuChart.new("single/weekly")
      expect(@chart.url).to eq("http://recochoku.jp/ranking/single/weekly/")
    end

    it "contains 50 rankings" do
      @chart = RecochokuChart.new("single/weekly")
      expect(@chart.rankings.length).to eq(50)
    end
  end

  context "daily albums chart specified" do
    it "returns the daily albums chart url" do
      @chart = RecochokuChart.new("album/daily")
      expect(@chart.url).to eq("http://recochoku.jp/ranking/album/daily/")
    end

    it "contains 50 rankings" do
      @chart = RecochokuChart.new("album/daily")
      expect(@chart.rankings.length).to eq(50)
    end
  end

  context "weekly albums chart specified" do
    it "returns the weekly albums chart url" do
      @chart = RecochokuChart.new("album/weekly")
      expect(@chart.url).to eq("http://recochoku.jp/ranking/album/weekly/")
    end

    it "contains 50 rankings" do
      @chart = RecochokuChart.new("album/weekly")
      expect(@chart.rankings.length).to eq(50)
    end
  end
end

RSpec.describe RecochokuRank do
  before :all do
    @rank = RecochokuRank.new("5", "Test Title", "Test Artist")
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