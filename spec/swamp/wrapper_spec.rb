require 'spec_helper'
module Swamp
  describe Wrapper do
    let(:fields) { fields = double('fields').as_null_object }
    let(:buttons) { buttons = double('buttons').as_null_object }
    let(:wrapper) { wrapper = Swamp::Wrapper.new(fields, buttons) }

    describe "#explore" do
      it "fires up the browser to a given url" do
        url = "www.fakepage.com"
        wrapper.should_receive(:visit).with(url).and_return("")
        wrapper.explore(url)
      end
    end

    describe "#scan" do
      it "delegates the parsing of the fields to the fields class" do
        fields.should_receive(:get).and_return(["username"])
        wrapper.scan
      end

      it "delegates the parsing of the buttons to the buttons class" do
        buttons.should_receive(:get).and_return(["log_in"])
        wrapper.scan
      end

      context "when elements were found" do
        it "returns an array of formatted code snippets" do
          fields.stub(:get).and_return(["User-name", "User Password"])
          wrapper.scan.should == ["def type_user_name(input)\n  source.fill_in(\"User-name\", with: input)\nend", "def type_user_password(input)\n  source.fill_in(\"User Password\", with: input)\nend"]
        end
      end

      context "when no elements were found" do
        it "returns an empty array" do
          fields.stub(:get).and_return([])
          wrapper.scan.should == []
        end
      end
    end
  end
end
