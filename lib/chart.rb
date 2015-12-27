require 'nokogiri'
require 'mechanize'
require_relative 'rank'
require 'json'

##
# Represents an Oricon music chart, found at oricon.co.jp/rank/
#
# Attributes:
# => url - HTTP url of chart
# => rankings - Array of Ranks containing data for individual tracks.
##
class Chart
  attr_reader :url, :rankings

  ##
  # Creates a new chart with rank data.
  #
  # Params:
  # => chart (optional) - specifies which chart to download.
  # The four charts available are:
  #   - Daily Singles Chart ("jsd")
  #   - Weekly Singles Chart ("jsw")
  #   - Daily Albums Chart ("jad")
  #   - Weekly Singles Chart ("jaw")
  #
  # If no specific chart is specified, then it defaults to the Daily Singles Chart.
  #
  ##
  def initialize(chart = nil)
    agent = Mechanize.new
    # Grab the most recent chart links from API hosted on Kimono
    response = agent.get('https://www.kimonolabs.com/api/49eulam0?apikey=' + ENV['NOKIRO_API'])
    json = JSON.parse(response.body)
    idx = 0 # location of chart link in JSON response
    pages = 0 # how many web pages of data the chart contains

    case chart
    when "jsd" # Daily singles
      idx = 0
      pages = 3
    when "jsw" # Weekly singles
      idx = 1
      pages = 5
    when "jad" # Daily albums
      idx = 2
      pages = 3
    when "jaw" # Weekly albums
      idx = 3
      pages = 5
    else
      idx = 0 # Default: daily singles
      pages = 3
    end

    @url = json["results"]["charts"][idx]["link"]

    # Get all chart data
    @rankings = url_to_ranks(@url)

    2.upto(pages) do |page|
      @rankings += url_to_ranks(@url + "p/" + page.to_s + "/")
    end

    # Add in all rank #s after all data has been retrieved.
    n = 1
    @rankings.each do |rank|
      rank.num = n.to_s
      n += 1
    end
  end
  
  # Prints chart out in a nice form
  def to_s
    puts @rankings.map{ |f| f.num + ". \"" + f.title + "\" by " + f.artist }
  end
  private

  ##
  # Given a URL, scrapes track titles and artists from HTML source
  # and creates an array of Rank objects with it
  # 
  # Params:
  # => url - the url whose source will be scrapped
  # 
  # Returns:
  # =>  rank_list - array of Ranks
  ##
  def url_to_ranks(url)
    utr_agent = Mechanize.new
    
    rank_list, title_list, artist_list = [], [], []

    utr_agent = utr_agent.get(url)

    # Track titles
    utr_agent.search('section.box-rank-entry h2.title').children.each do |c|
      title_list.push(c.text)
    end

    # Artist titles
    utr_agent.search('section.box-rank-entry p.name').children.each do |d|
      artist_list.push(d.text)
    end

    0.upto(title_list.length - 1) do |i|
      rank_list.push(Rank.new(title_list[i], artist_list[i]))
    end

    return rank_list
  end
end