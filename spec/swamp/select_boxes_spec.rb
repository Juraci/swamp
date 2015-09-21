require 'spec_helper'
module Swamp
  describe SelectBoxes do
    let(:select_boxes) { Swamp::SelectBoxes.new }

    it "delegates to capybara the responsibility to get the select box elements" do
      element = {'id' => "month", 'name' => "birthday_month"}
      allow(element).to receive(:visible?).and_return(true)
      allow(select_boxes.page).to receive(:execute_script).and_return(nil)
      expect(select_boxes.page).to receive(:all).with('select').and_return([element])
      select_boxes.get
    end

    context "when the element is visible" do
      context "when the select box has id" do
        let(:element) { {'id' => "month", 'name' => "birthday_month"} }

        before(:each) do
          allow(element).to receive(:visible?).and_return(true)
          allow(select_boxes.page).to receive(:all).with('select').and_return([element])
        end

        it "highlights the element" do
          expect(select_boxes.page).to receive(:execute_script).once
          select_boxes.get
        end

        it "returns the element in the array using the id as the name" do
          allow(select_boxes.page).to receive(:execute_script).and_return(nil)
          expect(select_boxes.get.size).to eq(1)
          expect(select_boxes.get.first.name).to eq("month")
        end

        it "returns the element in the array using the id as the selector" do
          allow(select_boxes.page).to receive(:execute_script).and_return(nil)
          expect(select_boxes.get.size).to eq(1)
          expect(select_boxes.get.first.selector).to eq("month")
          expect(select_boxes.get.first.prism_selector).to eq("'#month'")
        end
      end

      context "when the select element has name but no id" do
        let(:element) { {'name' => "birthday_month"} }

        before(:each) do
          allow(element).to receive(:visible?).and_return(true)
          allow(select_boxes.page).to receive(:all).with('select').and_return([element])
        end

        it "highlights the element" do
          expect(select_boxes.page).to receive(:execute_script).once
          select_boxes.get
        end

        it "returns the element in the array using the name as the name" do
          allow(select_boxes.page).to receive(:execute_script).and_return(nil)
          expect(select_boxes.get.size).to eq(1)
          expect(select_boxes.get.first.name).to eq("birthday_month")
        end

        it "returns the element in the array using the name as the selector" do
          allow(select_boxes.page).to receive(:execute_script).and_return(nil)
          expect(select_boxes.get.size).to eq(1)
          expect(select_boxes.get.first.selector).to eq("birthday_month")
          expect(select_boxes.get.first.prism_selector).to eq(%\"select[name='birthday_month']"\)
        end
      end

      context "when the select element doesn't has either id or name" do
        let(:element) { {'class' => "provider-select"} }

        before(:each) do
          allow(element).to receive(:visible?).and_return(true)
          allow(select_boxes.page).to receive(:all).with('select').and_return([element])
        end

        it "highlights the element" do
          expect(select_boxes.page).to receive(:execute_script).once
          select_boxes.get
        end

        it "returns the element in the array using the class as the name" do
          allow(select_boxes.page).to receive(:execute_script).and_return(nil)
          expect(select_boxes.get.size).to eq(1)
          expect(select_boxes.get.first.name).to eq("provider-select")
        end

        it "returns the element in the array using the class as the selector" do
          allow(select_boxes.page).to receive(:execute_script).and_return(nil)
          expect(select_boxes.get.size).to eq(1)
          expect(select_boxes.get.first.selector).to eq("provider-select")
          expect(select_boxes.get.first.prism_selector).to eq("'select.provider-select'")
        end
      end
    end
  end
end
