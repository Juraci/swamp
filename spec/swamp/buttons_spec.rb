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

    context "when the button element has text" do
      it "returns the element's text in the array" do
        element = {'id' => "u_0_2"}
        element.stub(:text).and_return("Sign Up")
        element.stub(:visible?).and_return(true)
        buttons.stub(:all).with('button').and_return([element])
        buttons.get.should == ["Sign Up"]
      end
    end

    context "when the button element has no text" do
      it "returns an empty array" do
        element = {'id' => "u_0_2"}
        element.stub(:text).and_return("")
        element.stub(:visible?).and_return(true)
        buttons.stub(:all).with('button').and_return([element])
        buttons.get.should == []
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
