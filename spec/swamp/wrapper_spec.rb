require 'spec_helper'
module Swamp
  describe Wrapper do
    describe "#explore" do
      it "fires up the browser to a given url" do
        url = "www.fakepage.com"
        meta_collection = []
        wrapper = Swamp::Wrapper.new(meta_collection)
        wrapper.should_receive(:visit).with(url).and_return("")
        wrapper.explore(url)
      end
    end

    describe "#scan" do
      let(:fields) { double('fields').as_null_object }
      let(:buttons) { double('buttons').as_null_object }
      let(:input_buttons) { double('input_buttons').as_null_object }
      let(:select_boxes) { double('select_boxes').as_null_object }
      let(:generic_element_collection) { double('generic_element_collection').as_null_object }

      it "delegates the responsibility of getting the elements for each element collection object" do
        meta_collection = [generic_element_collection]
        wrapper = Swamp::Wrapper.new(meta_collection)
        meta_collection.each { |element_collection| element_collection.should_receive(:get).and_return([]) }
        wrapper.scan
      end

      context "when field elements were found" do
        let(:field) { Swamp::Field.new("username", "username") }

        it "returns an array of formatted code snippets for fields only" do
          fields.stub(:get).and_return([field])
          buttons.stub(:get).and_return([])
          input_buttons.stub(:get).and_return([])
          select_boxes.stub(:get).and_return([])

          meta_collection = [fields, buttons, input_buttons, select_boxes]
          wrapper = Swamp::Wrapper.new(meta_collection)
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

          meta_collection = [fields, buttons, input_buttons, select_boxes]
          wrapper = Swamp::Wrapper.new(meta_collection)
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

          meta_collection = [fields, buttons, input_buttons, select_boxes]
          wrapper = Swamp::Wrapper.new(meta_collection)
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

          meta_collection = [fields, buttons, input_buttons, select_boxes]
          wrapper = Swamp::Wrapper.new(meta_collection)
          wrapper.scan.should == ["def select_month(option)\n  source.select(option, :from => \"month\")\nend"]
        end
      end

      context "when no elements were found" do
        it "returns an empty array" do
          fields.stub(:get).and_return([])
          buttons.stub(:get).and_return([])
          input_buttons.stub(:get).and_return([])
          select_boxes.stub(:get).and_return([])

          meta_collection = [fields, buttons, input_buttons, select_boxes]
          wrapper = Swamp::Wrapper.new(meta_collection)
          wrapper.scan.should == []
        end
      end
    end
  end
end
