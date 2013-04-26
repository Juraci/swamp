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

    context "when the button has a text" do
      it "returns the element value in the array" do
        element = {'id' => "u_0_2"}
        element.stub(:text).and_return("Sign Up")
        element.stub(:visible?).and_return(true)
        buttons.stub(:all).with('button').and_return([element])
        buttons.get.should == ["Sign Up"]
      end
    end

  end
end
