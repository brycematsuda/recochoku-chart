class Rank
  attr_reader :num, :title, :artist
  attr_accessor :num
  
  def initialize(num, title, artist)
    @num = num
    @title = title
    @artist = artist
  end
end