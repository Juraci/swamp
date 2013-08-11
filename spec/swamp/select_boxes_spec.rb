require 'spec_helper'
module Swamp
  describe SelectBoxes do
    let(:select_boxes) { Swamp::SelectBoxes.new }

    it "delegates to capybara the responsibility to get the select box elements" do
      element = {'id' => "month", 'name' => "birthday_month"}
      element.stub(:visible?).and_return(true)
      select_boxes.should_receive(:all).with('select').and_return([element])
      select_boxes.get
    end

    context "when the element is visible" do
      context "when the select box has id" do
        let(:element) { {'id' => "month", 'name' => "birthday_month"} }

        before(:each) do
          element.stub(:visible).and_return(true)
          select_boxes.stub(:all).with('select').and_return([element])
        end

        it "returns the element in the array using the id as the name" do
          select_boxes.get.should have(1).select_box
          select_boxes.get.first.name.should == "month"
        end

        it "returns the element in the array using the id as the selector" do
          select_boxes.get.should have(1).select_box
          select_boxes.get.first.selector.should == "month"
        end
      end

      context "when the select element has name but no id" do
        let(:element) { {'name' => "birthday_month"} }

        before(:each) do
          element.stub(:visible).and_return(true)
          select_boxes.stub(:all).with('select').and_return([element])
        end

        it "returns the element in the array using the name as the name" do
          select_boxes.get.should have(1).select_box
          select_boxes.get.first.name.should == "birthday_month"
        end

        it "returns the element in the array using the name as the selector" do
          select_boxes.get.should have(1).select_box
          select_boxes.get.first.selector.should == "birthday_month"
        end
      end
    end
  end
end
