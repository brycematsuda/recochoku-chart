require 'chart'
require 'rest_client'
require 'json'

RSpec.describe Chart, "#url" do

  before :all do
    # Only call the API once
    response = RestClient.get 'https://www.kimonolabs.com/api/49eulam0?apikey=' + ENV['NOKIRO_API']
    @json = JSON.parse(response.body)
  end

  context "no chart specified" do
    it "returns the daily singles chart url" do
      defaultUrl = @json["results"]["charts"].first["link"]
      chart = Chart.new
      expect(chart.url).to eq defaultUrl
    end
  end

  context "daily singles chart specified" do
    it "returns the daily singles chart url" do
      daily_singles_url = @json["results"]["charts"][0]["link"]
      chart = Chart.new("jsd")
      expect(chart.url).to eq daily_singles_url
    end
  end

  context "weekly singles chart specified" do
    it "returns the weekly singles chart url" do
      weekly_singles_url = @json["results"]["charts"][1]["link"]
      chart = Chart.new("jsw")
      expect(chart.url).to eq weekly_singles_url
    end
  end

  context "daily albums chart specified" do
    it "returns the daily albums chart url" do
      daily_album_url = @json["results"]["charts"][2]["link"]
      chart = Chart.new("jad")
      expect(chart.url).to eq daily_album_url
    end
  end

  context "weekly albums chart specified" do
    it "returns the weekly albums chart url" do
      weekly_album_url = @json["results"]["charts"][3]["link"]
      chart = Chart.new("jaw")
      expect(chart.url).to eq weekly_album_url
    end
  end

end