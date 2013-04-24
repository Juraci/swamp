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
        element = {'name' => "username", 'type' => "text"}
        element.stub(:visible?).and_return(true)
        wrapper.should_receive(:all).with('input').and_return([element])
        wrapper.fields
      end

      context "when the input element is visible has the name attribute and its type is text" do
        it "returns the element name in the array" do
          element = {'name' => "username", 'type' => "text"}
          element.stub(:visible?).and_return(true)
          wrapper.stub(:all).with('input').and_return([element])
          wrapper.fields.should == ["username"]
        end
      end

      context "when the input element is visible has the name attribute and its type is password" do
        it "returns the element name in the array" do
          element = {'name' => "username", 'type' => "password"}
          element.stub(:visible?).and_return(true)
          wrapper.stub(:all).with('input').and_return([element])
          wrapper.fields.should == ["username"]
        end
      end

      context "when the input element is not visible" do
        it "returns an empty array" do
          element = {'name' => "username", 'type' => "text"}
          element.stub(:visible?).and_return(false)
          wrapper.stub(:all).with('input').and_return([element])
          wrapper.fields.should == []
        end
      end

      context "when the input element has no name attribute" do
        it "returns an empty array" do
          element = {'name' => "", 'type' => "text"}
          element.stub(:visible?).and_return(true)
          wrapper.stub(:all).with('input').and_return([element])
          wrapper.fields.should == []
        end
      end

      context "when the input element type is not text" do
        it "returns an empty array" do
          element = {'name' => "username", 'type' => "radio"}
          element.stub(:visible?).and_return(true)
          wrapper.stub(:all).with('input').and_return([element])
          wrapper.fields.should == []
        end
      end
    end
  end
end
