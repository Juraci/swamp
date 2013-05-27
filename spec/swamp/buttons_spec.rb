require 'spec_helper'
module Swamp
  describe Buttons do
    let(:buttons) { buttons = Swamp::Buttons.new }

    it "delegates to capybara the responsibility to get the buttons" do
      element = {'id' => "u_0_2"}
      element.stub(:text).and_return("Sign Up")
      element.stub(:visible?).and_return(true)
      buttons.should_receive(:all).with('button').and_return([element])
      buttons.get
    end

    context "when the element is visible" do
      context "when the button element has text" do
        it "returns the element in the array using the text as both the name and the selector" do
          element = {'id' => "u_0_2"}
          element.stub(:text).and_return("Sign Up")
          element.stub(:visible?).and_return(true)
          buttons.stub(:all).with('button').and_return([element])
          buttons.get.should have(1).button
          buttons.get.each.first.name.should == "Sign Up"
          buttons.get.each.first.selector.should == "Sign Up"
        end

        context "when there is no id and the text is not eligible to be the methods name" do
          it "returns the element in the array using the text the selector and nil for the method's name" do
            element = {'id' => ""}
            element.stub(:text).and_return("$ 9.90 Buy")
            element.stub(:visible?).and_return(true)
            buttons.stub(:all).with('button').and_return([element])
            buttons.get.should have(1).button
            buttons.get.each.first.name.should be_nil
            buttons.get.each.first.selector.should == "$ 9.90 Buy"
          end
        end
      end

      context "when the button element has no text" do
        it "returns the element in the array using the id as both the name and the selector" do
          element = {'id' => "search-button"}
          element.stub(:text).and_return("")
          element.stub(:visible?).and_return(true)
          buttons.stub(:all).with('button').and_return([element])
          buttons.get.should have(1).button
          buttons.get.each.first.name.should == "search-button"
          buttons.get.each.first.selector.should == "search-button"
        end
      end
    end

    context "when the button element is not visible" do
      it "returns an empty array" do
        element = {'id' => "u_0_2"}
        element.stub(:text).and_return("Sign Up")
        element.stub(:visible?).and_return(false)
        buttons.stub(:all).with('button').and_return([element])
        buttons.get.should == []
      end
    end
  end
end
