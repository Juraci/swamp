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
        field = Swamp::Field.new("username", "username")
        fields.should_receive(:get).and_return([field])
        wrapper.scan
      end

      it "delegates the parsing of the buttons to the buttons class" do
        button = Swamp::Button.new("log_in", "log_in")
        buttons.should_receive(:get).and_return([button])
        wrapper.scan
      end

      context "when fields elements were found" do
        it "returns an array of formatted code snippets" do
          field = Swamp::Field.new("User-name", "User-name")
          fields.stub(:get).and_return([field])
          wrapper.scan.should == ["def type_user_name(input)\n  source.fill_in(\"User-name\", with: input)\nend"]
        end
      end

      context "when buttons elements were found" do
        it "returns an array of formatted code snippets" do
          button = Swamp::Button.new("Sign Up", "Sign Up")
          buttons.stub(:get).and_return([button])
          wrapper.scan.should == ["def sign_up\n  source.click_button(\"Sign Up\")\nend"]
        end
      end

      context "when the method's name is nil" do
        it "returns only the selector in the array" do
          button = Swamp::Button.new(nil, "$ 9.90 Buy")
          buttons.stub(:get).and_return([button])
          wrapper.scan.should == ["source.click_button(\"$ 9.90 Buy\")"]
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
