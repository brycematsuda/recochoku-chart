require 'nokogiri'
require 'mechanize'
require 'json'

module Nokiro
  ##
  # Represents an Recochoku music chart, found at http://recochoku.jp/ranking/
  #
  # Attributes:
  # => url - HTTP url of chart
  # => rankings - Array of Nokiro::Ranks containing data for individual tracks.
  ##
  class Chart
    attr_reader :url, :rankings

    ##
    # Creates a new chart with rank data.
    #
    # Params:
    # => chart (optional) - specifies which chart to download.
    #
    # If no specific chart is specified, then it defaults to the Daily Singles Chart.
    #
    ##
    def initialize(chart = nil)
      if (!chart)
        chart = "single/daily"
      end

      @url = "http://recochoku.jp/ranking/" + chart + "/"

      # Get all chart data
      @rankings = url_to_ranks(@url)
    end
    
    # Prints chart out in a nice form
    def to_s
      puts @rankings.map{ |f| f.num + ". '" + f.title + "' by " + f.artist }
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
      utr_agent.search('td.info a.ttl').children.each do |c|
        title_list.push(c.text)
      end

      # Artist titles
      utr_agent.search('td.info p a:not(:has(img))').children.each do |d|
        artist_list.push(d.text)
      end

      0.upto(49) do |i|
        rank_list.push(Nokiro::Rank.new((i + 1).to_s, title_list[i], artist_list[i]))
      end

      return rank_list
    end
  end

  ##
  # Represents a ranked musical item in an Recochoku chart.
  # 
  # Attributes:
  # => num - current rank #
  # => title - item title
  # => artist - item artist
  #
  ##
  class Rank
    attr_reader :num, :title, :artist

    def initialize(num, title, artist)
      @num = num
      @title = title
      @artist = artist
    end

    def to_s
      "#{@num}. '#{@title}' by #{@artist}"
    end
  end
end