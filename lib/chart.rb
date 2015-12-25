class Chart
  attr_reader :url

  def initialize
      response = RestClient.get 'https://www.kimonolabs.com/api/49eulam0?apikey=' + ENV['NOKIRO_API']
      json = JSON.parse(response.body)
      @url = json["results"]["charts"].first["link"]
  end
end