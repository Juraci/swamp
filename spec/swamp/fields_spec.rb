require 'spec_helper'
module Swamp
  describe Fields do
    let(:fields) { Swamp::Fields.new }

    it "delegates to capybara the responsibility to get the fields" do
      element = {'name' => "username", 'type' => "text"}
      allow(element).to receive(:visible?).and_return(true)
      allow(fields.page).to receive(:execute_script).and_return(nil)
      expect(fields.page).to receive(:all).with('input').and_return([element])
      fields.get
    end

    context "when the input element is visible" do
      context "when it has a valid type" do
        let (:type) { ["text", "email", "password"].sample }

        context "when it has the id and the name attribute" do
          let (:element) { {'name' => "username", 'type' => type, 'id' => "u_0_b"} }

          before(:each) do
            allow(element).to receive(:visible?).and_return(true)
            allow(fields.page).to receive(:all).with('input').and_return([element])
          end

          it "highlights the element" do
            expect(fields.page).to receive(:execute_script).twice
            fields.get
          end

          it "returns the element in the array using the name as the method's name" do
            allow(fields.page).to receive(:execute_script).and_return(nil)
            expect(fields.get.size).to eq(1)
            expect(fields.get.first.name).to eq("username")
          end

          it "returns the element in the array using the id as the selector" do
            allow(fields.page).to receive(:execute_script).and_return(nil)
            expect(fields.get.size).to eq(1)
            expect(fields.get.first.selector).to eq("u_0_b")
          end
        end

        context "when it has only the id attribute" do
          let (:element) { {'type' => type, 'id' => "username"} }

          before(:each) do
            allow(element).to receive(:visible?).and_return(true)
            allow(fields.page).to receive(:all).with('input').and_return([element])
          end

          it "highlights the element" do
            expect(fields.page).to receive(:execute_script).twice
            fields.get
          end

          it "returns the element in the array using the id as the method's name" do
            allow(fields.page).to receive(:execute_script).and_return(nil)
            expect(fields.get.size).to eq(1)
            expect(fields.get.first.name).to eq("username")
          end

          it "returns the element in the array using the id as the selector" do
            allow(fields.page).to receive(:execute_script).and_return(nil)
            expect(fields.get.size).to eq(1)
            expect(fields.get.first.selector).to eq("username")
          end
        end

        context "when it has only the name attribute" do
          let (:element) { {'name' => "username", 'type' => type} }

          before(:each) do
            allow(element).to receive(:visible?).and_return(true)
            allow(fields.page).to receive(:all).with('input').and_return([element])
          end

          it "highlights the element" do
            expect(fields.page).to receive(:execute_script).twice
            fields.get
          end

          it "returns the element in the array using the name as the method's name" do
            allow(fields.page).to receive(:execute_script).and_return(nil)
            expect(fields.get.size).to eq(1)
            expect(fields.get.first.name).to eq("username")
          end

          it "returns the element in the array using the name as the selector" do
            allow(fields.page).to receive(:execute_script).and_return(nil)
            expect(fields.get.size).to eq(1)
            expect(fields.get.first.selector).to eq("username")
          end
        end
      end

      context "when the input element type is invalid" do
        let (:type) { ["radio", "checkbox", "submit", "button"].sample }

        it "returns an empty array" do
          element = {'name' => "username", 'type' => type}
          allow(element).to receive(:visible?).and_return(true)
          allow(fields.page).to receive(:all).with('input').and_return([element])
          expect(fields.get).to eq([])
        end
      end
    end

    context "when the input element is not visible" do
      it "returns an empty array" do
        element = {'name' => "username", 'type' => "text"}
        allow(element).to receive(:visible?).and_return(false)
        allow(fields.page).to receive(:all).with('input').and_return([element])
        expect(fields.get).to eq([])
      end
    end
  end
end
