require 'chart'
require 'rest_client'
require 'json'

RSpec.describe Chart, "#url" do
  context "no specified chart" do
    it "returns the daily singles chart" do
      response = RestClient.get 'https://www.kimonolabs.com/api/49eulam0?apikey=' + ENV['NOKIRO_API']
      json = JSON.parse(response.body)
      defaultUrl = json["results"]["charts"].first["link"]
      chart = Chart.new
      expect(chart.url).to eq defaultUrl
    end
  end
end