require 'spec_helper'
include Geohashing

class Hasher
  include Geohashing
end

describe Geohashing do
  before(:each) do
    @hasher = Hasher.new
    @hasher.stub(:today) { "2005-05-26" }
    @hasher.stub(:last_dow_open) { 10458.68 }
  end

  describe "code_today" do
    it "should join the date and DJI" do
      @hasher.code_today.should == "2005-05-26-10458.68"
    end
  end

  describe "md5sum" do
    it "should correctly encode the string" do
      @hasher.md5sum(@hasher.code_today).should == "db9318c2259923d08b672cb305440f97"
    end
  end

  describe "md5split" do
    it "should split an md5sum into halves" do
      hsh = "db9318c2259923d08b672cb305440f97"
      md5split(hsh).should == ["db9318c2259923d0", "8b672cb305440f97"]
    end
  end

  describe "hex_to_dec" do
    it "should convert a hex string to a decimal string" do
      hex = "db9318c2259923d0"
      hex_to_dec(hex).should == "8577132"
    end
  end

  describe "graticule" do
    it "should round down a positive number" do
      pos = 37.421542
      graticule(pos).should == 37
    end
    it "should round down a negative number" do
      pos = -122.085589
      graticule(pos).should == -122
    end
  end

  describe "geohash" do
    it "should return the expected value" do
      @hasher.geohash(37.421542, -122.085589).should == [37.8577132, -122.544543]
    end
  end
end
