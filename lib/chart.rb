require 'nokogiri'
require 'open-uri'
require 'rank'

class Chart
  attr_reader :url, :rankings

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
      @rankings = data_to_ranks(Nokogiri::HTML(open(@url)))
    end
  end
  
  def data_to_ranks(data)
    rank_list = []

    data.css('section.box-rank-entry h2.title').children.each do |c|
      rank_list.push(Rank.new(c.text))
    end

    return rank_list
  end