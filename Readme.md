# Geohashing: a module implementing XKCD's geohashing algorithm

## lolwut?

[The inspirational comic](http://www.xkcd.com/426/)

[The geohashing community](http://wiki.xkcd.com/geohashing/Main_Page)

## Usage

Just include the Geohashing module in your class. The only *really* useful method is:

	Geohashing::geohash(lat, long)

which returns today's geohashing location in your [graticule](http://wiki.xkcd.com/geohashing/Graticule).

E.g., on 2005-05-26,

	Geohashing::geohash(37.421542, -122.085589) #=> [37.8577132, -122.544543]

## Caveat emptor

Since the module need to be able to look up the opening Dow Jones index, no network connection == no geohash. 

Note also that this module currently lacks:

- a command-line tool
- the ability to find previous geohashes
- [30W time zone support](http://wiki.xkcd.com/geohashing/30W_Time_Zone_Rule)

That being said, pull requests are welcome!
