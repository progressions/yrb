require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "YRB" do
  before(:each) do
    stub_file_io
  end
  
  describe "load_file" do
    before(:each) do
    end
    
    it "should load empty file" do
      @yrb = ""
      File.stub!(:read).with("path").and_return(@yrb)
      YRB.load_file("path").should == {}
    end
    
    it "should parse file" do
      @yrb = <<-YRB
FIRST=first key
      YRB
      File.stub!(:read).with("path").and_return(@yrb)
      YRB.load_file("path")["FIRST"].should == "first key"
    end
    
    it "should skip comments" do
      @yrb = <<-YRB
# comment
FIRST=first key

      YRB
      File.stub!(:read).with("path").and_return(@yrb)
      YRB.load_file("path")["FIRST"].should == "first key"
    end
    
    it "should skip non-keys" do
      @yrb = <<-YRB
not a comment but not a key
FIRST=first key
      YRB
      File.stub!(:read).with("path").and_return(@yrb)
      YRB.load_file("path")["FIRST"].should == "first key"      
    end
    
    describe "unique true" do
      it "should raise an error on duplicate keys" do
        @yrb = <<-YRB
FIRST=first key
FIRST=first key
        YRB
        File.stub!(:read).with("path").and_return(@yrb)
        lambda {
          YRB.load_file("path")
        }.should raise_error("Duplicate key error: FIRST")
      end
    end
  end
end
