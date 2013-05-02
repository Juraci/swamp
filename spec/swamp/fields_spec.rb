require 'spec_helper'
module Swamp
  describe Fields do
    let(:fields) { fields = Swamp::Fields.new }

    it "delegates to capybara the responsibility to get the fields" do
      element = {'name' => "username", 'type' => "text"}
      element.stub(:visible?).and_return(true)
      fields.should_receive(:all).with('input').and_return([element])
      fields.get
    end

    context "when the input element is visible has the name attribute and its type is valid" do
      it "returns the element in the array" do
        element = {'name' => "username", 'type' => "text"}
        element.stub(:visible?).and_return(true)
        fields.stub(:all).with('input').and_return([element])
        fields.get.should have(1).field
        fields.get.first.name.should == "username"
        fields.get.first.selector.should == "username"
      end
    end

    context "when the input element is not visible" do
      it "returns an empty array" do
        element = {'name' => "username", 'type' => "text"}
        element.stub(:visible?).and_return(false)
        fields.stub(:all).with('input').and_return([element])
        fields.get.should == []
      end
    end

    context "when the input element has no name attribute" do
      it "returns an empty array" do
        element = {'name' => "", 'type' => "text"}
        element.stub(:visible?).and_return(true)
        fields.stub(:all).with('input').and_return([element])
        fields.get.should == []
      end
    end

    context "when the input element type is invalid" do
      it "returns an empty array" do
        element = {'name' => "username", 'type' => "radio"}
        element.stub(:visible?).and_return(true)
        fields.stub(:all).with('input').and_return([element])
        fields.get.should == []
      end
    end
  end
end
