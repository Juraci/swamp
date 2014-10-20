require 'spec_helper'
module Swamp
  describe Links do
    let(:links) { Swamp::Links.new }

    it "delegates to capybara the responsibility to get the links" do
      element = {'id' => "forgot-password", 'href' => "https://somewhere.com"}
      allow(element).to receive(:visible?).and_return(true)
      allow(links.page).to receive(:execute_script).and_return(nil)
      expect(links.page).to receive(:all).with('a[href][id]').and_return([element])
      links.get
    end

    context "when the element is visible" do
      context "when the link has id" do
        let(:element) { {'id' => "forgot-password", 'href' => "https://somewhere.com"} }

        before(:each) do
          allow(element).to receive(:visible?).and_return(true)
          allow(links.page).to receive(:all).with('a[href][id]').and_return([element])
        end

        it "highlights the element" do
          expect(links.page).to receive(:execute_script).and_return(nil)
          links.get
        end

        it "returns the element in the array using the id as the name" do
          allow(links.page).to receive(:execute_script).and_return(nil)
          expect(links.get.size).to eq(1)
          expect(links.get.first.name).to eq("forgot-password")
        end

        it "returns the element in the array using the id as the selector" do
          allow(links.page).to receive(:execute_script).and_return(nil)
          expect(links.get.size).to eq(1)
          expect(links.get.first.selector).to eq("forgot-password")
          expect(links.get.first.prism_selector).to eq("'#forgot-password'")
        end
      end
    end
  end
end
