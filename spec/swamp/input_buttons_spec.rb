require 'spec_helper'
module Swamp
  describe InputButtons do
    let(:input_buttons) { Swamp::InputButtons.new }

    it "delegates to capybara the responsibility to get the submit elements" do
      element = {'value' => "Log In", 'id' => "u_0_b"}
      element.stub(:visible?).and_return(true)
      input_buttons.should_receive(:all).with('input[type="submit"]').and_return([element])
      input_buttons.get
    end

    context "when the element is visible" do
      context "when the submit element has value and id" do
        let(:element) { {'value' => "Log In", 'id' => "u_0_b"} }

        before(:each) do
          element.stub(:visible?).and_return(true)
          input_buttons.stub(:all).with('input[type="submit"]').and_return([element])
        end

        it "returns the element in the array using the value as the name" do
          input_buttons.get.should have(1).input_submit
          input_buttons.get.first.name.should == "Log In"
        end

        it "returns the element in the array using the id as the selector" do
          input_buttons.get.should have(1).input_submit
          input_buttons.get.first.selector.should == "#u_0_b"
        end
      end

      context "when the submit element has value but has no id" do
        let(:element) { {'value' => "Log In", 'class' => "btn without id"} }

        before(:each) do
          element.stub(:visible?).and_return(true)
          input_buttons.stub(:all).with('input[type="submit"]').and_return([element])
        end

        it "returns the element in the array using the value as the name" do
          input_buttons.get.should have(1).input_submit
          input_buttons.get.first.name.should == "Log In"
        end

        it "returns the element in the array using the class concatenated with the value as the selector" do
          input_buttons.get.should have(1).input_submit
          input_buttons.get.first.selector.should == "input.btn.without.id[value='Log In']"
        end
      end
    end

    context "when the element is not visible" do
      it "returns an empty array" do
        element = {'value' => "Log In", 'id' => "u_0_b"}
        element.stub(:visible?).and_return(false)
        input_buttons.stub(:all).with('input[type="submit"]').and_return([element])
        input_buttons.get.should == []
      end
    end
  end
end
