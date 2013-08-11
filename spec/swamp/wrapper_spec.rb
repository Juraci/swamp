require 'spec_helper'
module Swamp
  describe Wrapper do
    let(:fields) { double('fields').as_null_object }
    let(:buttons) { double('buttons').as_null_object }
    let(:input_buttons) { double('input_buttons').as_null_object }
    let(:select_boxes) { double('select_boxes').as_null_object }
    let(:wrapper) { Swamp::Wrapper.new(fields, buttons, input_buttons, select_boxes) }

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

    describe "#snippets_for_select_boxes" do
      context "when select box elements were found" do
        it "returns an array of formatted code snippets" do
          select_box = Swamp::SelectBox.new("month", "month")
          select_boxes.stub(:get).and_return([select_box])
          wrapper.snippets_for_select_boxes.should == ["def select_month(option)\n  source.select(option, :from => \"month\")\nend"]
        end
      end
    end

    describe "#scan" do
      context "when field elements were found" do
        let(:field) { Swamp::Field.new("username", "username") }

        it "returns an array of formatted code snippets for fields only" do
          fields.stub(:get).and_return([field])
          buttons.stub(:get).and_return([])
          input_buttons.stub(:get).and_return([])
          select_boxes.stub(:get).and_return([])

          wrapper.scan.should == ["def type_username(input)\n  source.fill_in(\"username\", with: input)\nend"]
        end
      end

      context "when button elements were found" do
        let(:button) { Swamp::Button.new("log_in", "log_in") }

        it "returns an array of formatted code snippets for fields only" do
          buttons.stub(:get).and_return([button])
          fields.stub(:get).and_return([])
          input_buttons.stub(:get).and_return([])
          select_boxes.stub(:get).and_return([])

          wrapper.scan.should == ["def log_in\n  source.click_button(\"log_in\")\nend"]
        end
      end

      context "when input button elements were found" do
        let(:input_button) { Swamp::InputButton.new("Log In", "input#u_0_b") }

        it "returns an array of formatted code snippets for input buttons only" do
          buttons.stub(:get).and_return([])
          fields.stub(:get).and_return([])
          input_buttons.stub(:get).and_return([input_button])
          select_boxes.stub(:get).and_return([])

          wrapper.scan.should == ["def log_in\n  source.find(:css, \"input#u_0_b\").click\nend"]
        end
      end

      context "when select box elements were found" do
        let(:select_box) { Swamp::SelectBox.new("month", "month") }

        it "returns an array of formatted code snippets for select boxes only" do
          buttons.stub(:get).and_return([])
          fields.stub(:get).and_return([])
          input_buttons.stub(:get).and_return([])
          select_boxes.stub(:get).and_return([select_box])

          wrapper.scan.should == ["def select_month(option)\n  source.select(option, :from => \"month\")\nend"]
        end
      end

      context "when no elements were found" do
        it "returns an empty array" do
          fields.stub(:get).and_return([])
          buttons.stub(:get).and_return([])
          input_buttons.stub(:get).and_return([])
          select_boxes.stub(:get).and_return([])

          wrapper.scan.should == []
        end
      end
    end
  end
end
