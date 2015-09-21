require 'spec_helper'
module Swamp
  describe InputButtons do
    let(:input_buttons) { Swamp::InputButtons.new }

    it "delegates to capybara the responsibility to get the submit elements" do
      element = {'value' => "Log In", 'id' => "u_0_b"}
      allow(element).to receive(:visible?).and_return(true)
      allow(input_buttons.page).to receive(:execute_script).and_return(nil)
      expect(input_buttons.page).to receive(:all).with('input[type="submit"],input[type="button"]').and_return([element])
      input_buttons.get
    end

    context "when the element is visible" do
      context "when the submit element has value and id" do
        let(:element) { {'value' => "Log In", 'id' => "u_0_b"} }

        before(:each) do
          allow(element).to receive(:visible?).and_return(true)
          allow(input_buttons.page).to receive(:all).with('input[type="submit"],input[type="button"]').and_return([element])
        end

        it "highlights the element" do
          expect(input_buttons.page).to receive(:execute_script).twice
          input_buttons.get
        end

        it "returns the element in the array using the value as the name" do
          allow(input_buttons.page).to receive(:execute_script).and_return(nil)
          expect(input_buttons.get.size).to eq(1)
          expect(input_buttons.get.first.name).to eq("Log In")
        end

        it "returns the element in the array using the id as the selector" do
          allow(input_buttons.page).to receive(:execute_script).and_return(nil)
          expect(input_buttons.get.size).to eq(1)
          expect(input_buttons.get.first.selector).to eq("#u_0_b")
        end
      end

      context "when the submit element has value but has no id" do
        let(:element) { {'value' => "Log In", 'class' => "btn without id"} }

        before(:each) do
          allow(element).to receive(:visible?).and_return(true)
          allow(input_buttons.page).to receive(:all).with('input[type="submit"],input[type="button"]').and_return([element])
        end

        it "highlights the element" do
          expect(input_buttons.page).to receive(:execute_script).twice
          input_buttons.get
        end

        it "returns the element in the array using the value as the name" do
          allow(input_buttons.page).to receive(:execute_script).and_return(nil)
          expect(input_buttons.get.size).to eq(1)
          expect(input_buttons.get.first.name).to eq("Log In")
        end

        it "returns the element in the array using the class concatenated with the value as the selector" do
          allow(input_buttons.page).to receive(:execute_script).and_return(nil)
          expect(input_buttons.get.size).to eq(1)
          expect(input_buttons.get.first.selector).to eq("input.btn.without.id[value='Log In']")
          expect(input_buttons.get.first.prism_selector).to eq(%\"input.btn.without.id[value='Log In']"\)
        end
      end
    end

    context "when the element is not visible" do
      it "returns an empty array" do
        element = {'value' => "Log In", 'id' => "u_0_b"}
        allow(element).to receive(:visible?).and_return(false)
        allow(input_buttons.page).to receive(:all).with('input[type="submit"],input[type="button"]').and_return([element])
        expect(input_buttons.get).to eq([])
      end
    end
  end
end
