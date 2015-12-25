class Chart
  attr_reader :url

  def initialize(chart = nil)
      response = RestClient.get 'https://www.kimonolabs.com/api/49eulam0?apikey=' + ENV['NOKIRO_API']
      json = JSON.parse(response.body)
      idx = 0

      case chart
      when "jsd" # Daily singles
        idx = 0
      when "jsw" # Weekly singles
        idx = 1
      when "jad" # Daily albums
        idx = 2
      when "jaw" # Weekly albums
        idx = 3
      else
        idx = 0 # Default: daily singles
      end

      @url = json["results"]["charts"][idx]["link"]
  end
end