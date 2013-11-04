require 'spec_helper'
module Swamp
  describe Links do
    let(:links) { Swamp::Links.new }

    it "delegates to capybara the responsibility to get the links" do
      element = {'id' => "forgot-password", 'href' => "https://somewhere.com"}
      element.stub(:visible?).and_return(true)
      links.page.stub(:execute_script).and_return(nil)
      links.page.should_receive(:all).with('a[href][id]').and_return([element])
      links.get
    end

    context "when the element is visible" do
      context "when the link has id" do
        let(:element) { {'id' => "forgot-password", 'href' => "https://somewhere.com"} }

        before(:each) do
          element.stub(:visible?).and_return(true)
          links.page.stub(:all).with('a[href][id]').and_return([element])
        end

        it "highlights the element" do
          links.page.should_receive(:execute_script).and_return(nil)
          links.get
        end

        it "returns the element in the array using the id as the name" do
          links.page.stub(:execute_script).and_return(nil)
          links.get.should have(1).link
          links.get.first.name.should == "forgot-password"
        end

        it "returns the element in the array using the id as the selector" do
          links.page.stub(:execute_script).and_return(nil)
          links.get.should have(1).select_box
          links.get.first.selector.should == "forgot-password"
        end
      end
    end
  end
end
