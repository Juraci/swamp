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
        let(:element) { {'id' => "u_0_2"} }

        before(:each) do
          element.stub(:visible?).and_return(true)
          element.stub(:text).and_return("Sign Up")
          buttons.stub(:all).with('button').and_return([element])
        end

        it "returns the element in the array using the text as both the name and the selector" do
          buttons.get.should have(1).button
          buttons.get.each.first.name.should == "Sign Up"
          buttons.get.each.first.selector.should == "Sign Up"
        end
      end

      context "when the button element has no text" do
        context "when the button element has id" do
          let(:element) { {'id' => "search-button"} }

          before(:each) do
            element.stub(:visible?).and_return(true)
            element.stub(:text).and_return("")
            buttons.stub(:all).with('button').and_return([element])
          end

          it "returns the element in the array using the id as both the name and the selector" do
            buttons.get.should have(1).button
            buttons.get.each.first.name.should == "search-button"
            buttons.get.each.first.selector.should == "search-button"
          end
        end

        context "when the button element has no id" do
          context "when the button element has value" do
            let(:element) { {'value' => "search-button", 'id' => ""} }

            before(:each) do
              element.stub(:visible?).and_return(true)
              element.stub(:text).and_return("")
              buttons.stub(:all).with('button').and_return([element])
            end

            it "returns the element in the array using the value as both the name and the selector" do
              buttons.get.should have(1).button
              buttons.get.each.first.name.should == "search-button"
              buttons.get.each.first.selector.should == "search-button"
            end
          end

          context "when the button element has no value" do
            let(:element) { {'value' => "", 'id' => ""} }

            before(:each) do
              element.stub(:visible?).and_return(true)
              element.stub(:text).and_return("")
              buttons.stub(:all).with('button').and_return([element])
            end

            it "returns an empty array" do
              buttons.stub(:all).with('button').and_return([element])
              buttons.get.should == []
            end
          end
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
