##
# Represents a ranked musical item in an Oricon chart.
# 
# Attributes:
# => num - current rank #
# => title - item title
# => artist - item artist
#
##
class Rank
  attr_reader :num, :title, :artist
  attr_accessor :num

  def initialize(title, artist, num = "")
    @num = num
    @title = title
    @artist = artist
  end
end