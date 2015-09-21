require 'spec_helper'
module Swamp
  describe Buttons do
    let(:buttons) { buttons = Swamp::Buttons.new }

    it "delegates to capybara the responsibility to get the buttons" do
      element = {'id' => "u_0_2"}
      allow(element).to receive(:text).and_return("Sign Up")
      allow(element).to receive(:visible?).and_return(true)
      allow(buttons.page).to receive(:execute_script).and_return(nil)
      expect(buttons.page).to receive(:all).with('button').and_return([element])
      buttons.get
    end

    context "when the element is visible" do
      context "when the button element has text" do
        let(:element) { {'id' => "u_0_2"} }

        before(:each) do
          allow(element).to receive(:visible?).and_return(true)
          allow(element).to receive(:text).and_return("Sign Up")
          allow(buttons.page).to receive(:all).with('button').and_return([element])
        end

        it "highlights the element" do
          expect(buttons.page).to receive(:execute_script).twice
          buttons.get
        end

        it "returns the element in the array using the text as both the name and the selector" do
          allow(buttons.page).to receive(:execute_script).and_return(nil)
          expect(buttons.get.size).to eq(1)
          expect(buttons.get.first.name).to eq("Sign Up")
          expect(buttons.get.first.selector).to eq("u_0_2")
          expect(buttons.get.first.prism_selector).to eq("'#u_0_2'")
        end
      end

      context "when the button element has no text" do
        context "when the button element has id" do
          let(:element) { {'id' => "search-button"} }

          before(:each) do
            allow(element).to receive(:visible?).and_return(true)
            allow(element).to receive(:text).and_return("")
            allow(buttons.page).to receive(:all).with('button').and_return([element])
          end

          it "highlights the element" do
            expect(buttons.page).to receive(:execute_script).twice
            buttons.get
          end

          it "returns the element in the array using the id as both the name and the selector" do
            allow(buttons.page).to receive(:execute_script).and_return(nil)
            expect(buttons.get.size).to eq(1)
            expect(buttons.get.first.name).to eq("search-button")
            expect(buttons.get.first.selector).to eq("search-button")
            expect(buttons.get.first.prism_selector).to eq("'#search-button'")
          end
        end

        context "when the button element has no id" do
          context "when the button element has value" do
            let(:element) { {'value' => "search-button", 'id' => ""} }

            before(:each) do
              allow(element).to receive(:visible?).and_return(true)
              allow(element).to receive(:text).and_return("")
              allow(buttons.page).to receive(:all).with('button').and_return([element])
            end

            it "highlights the element" do
              expect(buttons.page).to receive(:execute_script).twice
              buttons.get
            end

            it "returns the element in the array using the value as both the name and the selector" do
              allow(buttons.page).to receive(:execute_script).and_return(nil)
              expect(buttons.get.size).to eq(1)
              expect(buttons.get.each.first.name).to eq("search-button")
              expect(buttons.get.each.first.selector).to eq("search-button")
              expect(buttons.get.each.first.prism_selector).to eq(%\"[value='search-button']"\)
            end
          end

          context "when the button element has no value" do
            let(:element) { {'value' => "", 'id' => ""} }

            before(:each) do
              allow(element).to receive(:visible?).and_return(true)
              allow(element).to receive(:text).and_return("")
              allow(buttons.page).to receive(:all).with('button').and_return([element])
            end

            it "returns an empty array" do
              allow(buttons).to receive(:all).with('button').and_return([element])
              expect(buttons.get).to eq([])
            end
          end
        end
      end
    end

    context "when the button element is not visible" do
      it "returns an empty array" do
        element = {'id' => "u_0_2"}
        allow(element).to receive(:text).and_return("Sign Up")
        allow(element).to receive(:visible?).and_return(false)
        allow(buttons.page).to receive(:all).with('button').and_return([element])
        expect(buttons.get).to eq([])
      end
    end
  end
end
