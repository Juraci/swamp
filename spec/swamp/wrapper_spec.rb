require 'spec_helper'
module Swamp
  describe Wrapper do
    let(:fields) { double('fields').as_null_object }
    let(:buttons) { double('buttons').as_null_object }
    let(:input_buttons) { double('input_buttons').as_null_object }
    let(:wrapper) { Swamp::Wrapper.new(fields, buttons, input_buttons) }

    describe "#explore" do
      it "fires up the browser to a given url" do
        url = "www.fakepage.com"
        wrapper.should_receive(:visit).with(url).and_return("")
        wrapper.explore(url)
      end
    end

    describe "#snippets_for_fields" do
      context "when field elements were found" do
        it "returns an array of formatted code snippets" do
          field = Swamp::Field.new("User-name", "User-name")
          fields.stub(:get).and_return([field])
          wrapper.snippets_for_fields.should == ["def type_user_name(input)\n  source.fill_in(\"User-name\", with: input)\nend"]
        end
      end
    end

    describe "#snippets_for_buttons" do
      context "when button elements were found" do
        it "returns an array of formatted code snippets" do
          button = Swamp::Button.new("Sign Up", "Sign Up")
          buttons.stub(:get).and_return([button])
          wrapper.snippets_for_buttons.should == ["def sign_up\n  source.click_button(\"Sign Up\")\nend"]
        end
      end
    end

    describe "#snippets_for_input_buttons" do
      context "when input of type submit elements were found" do
        it "returns an array of formatted code snippets" do
          input_button = Swamp::InputButton.new("Log In", "input#u_0_b")
          input_buttons.stub(:get).and_return([input_button])
          wrapper.snippets_for_input_buttons.should == ["def log_in\n  source.find(:css, \"input#u_0_b\").click\nend"]
        end
      end
    end

    describe "#scan" do
      context "when elements were found" do
        let(:field) { Swamp::Field.new("username", "username") }
        let(:button) { Swamp::Button.new("log_in", "log_in") }
        let(:input_button) { Swamp::InputButton.new("Log In", "input#u_0_b") }

        it "returns an array of formatted code snippets" do
          fields.stub(:get).and_return([field])
          buttons.stub(:get).and_return([button])
          input_buttons.stub(:get).and_return([input_button])
          wrapper.scan.should == ["def type_username(input)\n  source.fill_in(\"username\", with: input)\nend",
                                  "def log_in\n  source.click_button(\"log_in\")\nend",
                                  "def log_in\n  source.find(:css, \"input#u_0_b\").click\nend"]
        end
      end

      context "when only one kind of element is found" do
        let(:field) { Swamp::Field.new("username", "username") }

        it "returns an array of formatted code snippets for this element only" do
          fields.stub(:get).and_return([field])
          buttons.stub(:get).and_return([])
          input_buttons.stub(:get).and_return([])
          wrapper.scan.should == ["def type_username(input)\n  source.fill_in(\"username\", with: input)\nend"]
        end
      end

      context "when no elements were found" do
        it "returns an empty array" do
          fields.stub(:get).and_return([])
          buttons.stub(:get).and_return([])
          input_buttons.stub(:get).and_return([])
          wrapper.scan.should == []
        end
      end
    end
  end
end
