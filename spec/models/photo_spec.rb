require 'spec_helper'

describe Photo do
  before(:each) do
    @attr = {
      :image => File.new(Rails.root.join("spec/fixtures/sample.jpg")),
      :fromIP => "127.0.0.1",
      :browserDetails => "Something about a browser"
    }
  end
  
  it "should create a new instance given valid attributes" do
    Photo.create!(@attr)
  end
  
  it "should require a browser string" do
    noBrowserPhoto = Photo.new(@attr.merge(:browserDetails => ""))
    noBrowserPhoto.should_not be_valid
  end
  
  it "should require an IP address" do
    noIPPhoto = Photo.new(@attr.merge(:fromIP => ""))
    noIPPhoto.should_not be_valid
  end
  
  describe "IP address validations" do
    it "should reject IP addresses with non-numeric" do
      p = Photo.new(@attr.merge(:fromIP => "hello"))
      p.should_not be_valid
    end
    
    it "should reject IP addresses without enough parts" do
      p = Photo.new(@attr.merge(:fromIP => "127.0.0"))
      p.should_not be_valid
    end
    
    it "should reject out of range IP addresses" do
      p = Photo.new(@attr.merge(:fromIP => "256.0.0.1"))
      p.should_not be_valid
    end
    
    it "should reject IP addresses with too many parts" do
      p = Photo.new(@attr.merge(:fromIP => "127.0.0.1.0"))
      p.should_not be_valid
    end
  end
  
  it "should require an image" do
    nophoto = Photo.new(@attr.merge(:image => ""))
    nophoto.should_not be_valid
  end
    
end
