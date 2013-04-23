require 'spec_helper'
module  Swamp
  describe Wrapper do

    let(:wrapper) { wrapper = Swamp::Wrapper.new }

    describe "#explore" do
      it "fires up the browser to a given url" do
        url = "www.fakepage.com"
        wrapper.should_receive(:visit).with(url).and_return("")
        wrapper.explore(url)
      end
    end

    describe "#scan" do
      it "scans the page and returns the field elements" do
        wrapper.should_receive(:fields).and_return(["username"])
        wrapper.scan
      end

      it "formats the elements to code snippets" do
        wrapper.stub(:fields).and_return(["username"])
        wrapper.scan.should == ["def type_username(input)\n  source.fill_in(\"username\", with: input)\nend"]
      end
    end

    describe "#fields" do
      it "delegates to capybara the responsibility to get the fields" do
        wrapper.should_receive(:all).with('input').and_return(["element"])
        wrapper.fields
      end
    end

  end
end
