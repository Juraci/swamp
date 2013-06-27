require 'spec_helper'
module Swamp
  describe Evaluator do
    let(:wrapper) { wrapper = double('wrapper').as_null_object }

    describe "#valid_url?" do
      context "when the url is valid" do
        context "when it starts with 'http://'" do
          it "returns true" do
            input = "http://fakepage.com"
            evaluator = Swamp::Evaluator.new(input, wrapper)
            evaluator.should be_valid_url
          end
        end

        context "when it starts with 'https://'" do
          it "returns true" do
            input = "https://fakepage.com"
            evaluator = Swamp::Evaluator.new(input, wrapper)
            evaluator.should be_valid_url
          end
        end

        context "when it starts with 'file://'" do
          it "returns true" do
            input = "file://fakepage.html"
            evaluator = Swamp::Evaluator.new(input, wrapper)
            evaluator.should be_valid_url
          end
        end
      end

      context "when the url is invalid" do
        context "when the protocol prefix is missing" do
          it "returns false" do
            input = "www.fakepage.com"
            evaluator = Swamp::Evaluator.new(input, wrapper)
            evaluator.should_not be_valid_url
          end
        end
      end
    end

    describe "#refresh_command?" do
      context "when the input is an enter keystroke" do
        context "when a page was already visited" do
          it "returns true" do
            wrapper.stub(:page_visited).and_return(true)
            input = "\n"
            evaluator = Swamp::Evaluator.new(input, wrapper)
            evaluator.should be_refresh_command
          end
        end

        context "when no page was yet visited" do
          it "returns false" do
            wrapper.stub(:page_visited).and_return(false)
            input = "\n"
            evaluator = Swamp::Evaluator.new(input, wrapper)
            evaluator.should_not be_refresh_command
          end
        end
      end

      context "when the input is not an enter keystroke" do
        it "returns false" do
          wrapper.stub(:page_visited).and_return(true)
          input = " "
          evaluator = Swamp::Evaluator.new(input, wrapper)
          evaluator.should_not be_refresh_command
        end
      end
    end
  end
end
