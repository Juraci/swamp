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

    context "when the input element is visible and has the name attribute" do
      context "when its type is text" do
        it "returns the element in the array" do
          element = {'name' => "username", 'type' => "text"}
          element.stub(:visible?).and_return(true)
          fields.stub(:all).with('input').and_return([element])
          fields.get.should have(1).field
          fields.get.first.name.should == "username"
          fields.get.first.selector.should == "username"
        end
      end

      context "when its type is email" do
        it "returns the element in the array" do
          element = {'name' => "useremail", 'type' => "email"}
          element.stub(:visible?).and_return(true)
          fields.stub(:all).with('input').and_return([element])
          fields.get.should have(1).field
          fields.get.first.name.should == "useremail"
          fields.get.first.selector.should == "useremail"
        end
      end

      context "when its type is password" do
        it "returns the element in the array" do
          element = {'name' => "password", 'type' => "password"}
          element.stub(:visible?).and_return(true)
          fields.stub(:all).with('input').and_return([element])
          fields.get.should have(1).field
          fields.get.first.name.should == "password"
          fields.get.first.selector.should == "password"
        end
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
