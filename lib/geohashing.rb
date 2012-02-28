require 'net/http'
require 'rexml/document'
require 'digest'

module Geohashing
  def last_dow_open
    dow_query = "http://www.google.com/ig/api?stock=.DJI"
    doc_data = Net::HTTP.get_response(URI.parse(dow_query)).body
    doc = REXML::Document.new doc_data
    doc.elements["xml_api_reply/finance/open"].attributes["data"].to_f
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

  def hex_to_dec h
    h.to_i(16).to_s
  end

  def base_position pos
    pos < 0 ? pos.ceil : pos.floor
  end 

  def geohash lat, long
    lat, long = base_position(lat), base_position(long)
    lat_dec, long_dec = md5split(md5sum(code_today)).map{ |s| hex_to_dec s }
    ["#{lat}.#{lat_dec}".to_f, "#{long}.#{long_dec}".to_f]
  end
end

