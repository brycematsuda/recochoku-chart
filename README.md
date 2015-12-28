# recochoku-chart

Unofficial Ruby API for Recochoku music charts.

## background
[from siliconera:](http://www.siliconera.com/2014/11/20/bunch-people-japan-using-nintendo-3ds-buy-listen-music/#WgeTe88mjJpY5ecH.99)

> To give you an idea of what RecoChoku is about, it was the first Japanese website to sell ringtones in Japan. Since then, they’ve grown into a bigger company that sells music downloads, CDs and DVDs, along with e-books and other digital content.

>RecoChoku currently allows people to purchase downloads of singles, albums, video clips, ringtones, and more. They also have a flat-rate service that lets you check out all the J-pop you could ask for. The website also a pretty popular website to check out the latest top hits.

----
##dependencies
- Ruby 2.0.0 or greater
- Mechanize

----
## installation

    gem install recochoku-chart


or you can clone this repository and run

    gem build recochoku-chart.gemspec
    gem install ./recochoku-chart-0.0.0.gem

----
##  quickstart

A Recochoku chart is represented by the RecochokuChart class. By default, it contains the daily singles chart, but a specific chart can be specified in the constructor if the chart URL is of the form:

    http://recochoku.jp/ranking/{type}/{frequency}/

"type" denotes the type of media (e.g: single, album) and "frequency" denotes how often the chart is released (e.g. daily, weekly, monthly).

Some example parameters that can be put in the constructor:

* "daily/single"
* "weekly/single"
* "daily/album"
* "weekly/album"
----
    2.3.0 :001 > require 'recochoku-chart'
     => true
    2.3.0 :002 > chart = RecochokuChart.new("single/daily")
     => #<RecochokuChart:0x0000000276c800 @url="http://recochoku.jp/ranking/single/daily/", 
    @rankings=[#<RecochokuRank:0x000000026bac40 @num="1", @title="クリスマスソング", @artist="back number">, 
    #<RecochokuRank:0x000000026babf0 @num="2", @title="365日の紙飛行機", @artist="AKB48">, 
    #<RecochokuRank:0x000000026baba0 @num="3", @title="海の声", @artist="浦島太郎 (桐谷健太)">...

The RecochokuChart class has a custom ```to_s``` method that prints out the chart in a readable manner.

This is the daily singles chart for December 27, 2015.

    2.3.0 :003 > chart.to_s
     1. 'クリスマスソング' by back number
     2. '365日の紙飛行機' by AKB48
     3. '海の声' by 浦島太郎 (桐谷健太)
     4. 'SUN' by 星野 源
     5. '未来' by コブクロ
     ...
     50. 'はなまるぴっぴはよいこだけ' by A応P

Each individual rank's attributes can also be accessed as such:

    2.3.0 :006 > song = chart.rankings[0]
     => #<RecochokuRank:0x000000026bac40 @num="1", @title="クリスマスソング", @artist="back number"> 
    2.3.0 :007 > song.num # Rank
     => "1" 
    2.3.0 :008 > song.title
     => "クリスマスソング" 
    2.3.0 :009 > song.artist
     => "back number" 

----
## testing

Tests can be run with:
     
    bundle exec rspec spec --format doc

----
## contributions

If you'd like to add any new features, tests, or bugfixes, please make an appropriate pull request.

----
## license

MIT

