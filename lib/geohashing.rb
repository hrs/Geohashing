require 'net/http'
require 'digest'

module Geohashing
  # using the peeron API
  # see: http://wiki.xkcd.com/geohashing/Dow_Jones_Industrial_Average
  def last_dow_open
    url = Time.new.strftime("http://carabiner.peeron.com/xkcd/map/data/%Y/%m/%d")
    Net::HTTP.get_response(URI.parse(url)).body.to_f
  end

  def today
    Time.now.strftime("%Y-%m-%d")
  end

  def code_today
    "#{today}-#{last_dow_open.to_s}"
  end

  def md5sum str
    Digest::MD5.hexdigest str
  end 

  def md5split sum
    [sum[0..15], sum[16..31]]
  end

  # this method slightly modified from ScottKuma's
  # "Ruby Geohasher v1.2" implementation
  # http://wiki.xkcd.com/geohashing/Implementations#Ruby_Geohasher_v1.2
  def hex_to_dec h
    fracLen = h.length
    fracPortion = h[0..(fracLen-1)]
    fracLen = fracPortion.length
    len = (fracLen - 1)
    sum = 0
    (0..len).each do |i|
      numSixteenths = fracPortion[i..i].to_i(16)
      conversionFactor = (16.**(i + 1)).to_f
      conversionFactor = 1./conversionFactor
      sum = sum + ((numSixteenths) * conversionFactor)
    end
    return sum.to_s[2..8]
  end

  def graticule pos
    pos < 0 ? pos.ceil : pos.floor
  end 

  def geohash lat, long
    lat, long = graticule(lat), graticule(long)
    lat_dec, long_dec = md5split(md5sum(code_today)).map{ |s| hex_to_dec s }
    ["#{lat}.#{lat_dec}".to_f, "#{long}.#{long_dec}".to_f]
  end
end

