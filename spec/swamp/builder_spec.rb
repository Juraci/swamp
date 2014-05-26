require 'spec_helper'
module Swamp
  describe Builder do
    describe "#build_method" do
      context "when the type is field" do
        let(:type) { :field }
        context "when the name and the selector are present" do
          it "returns the method's snippet" do
            element = Swamp::Field.new("User-Name", "User-Name")
            builder = Swamp::Builder.new(element)
            builder.build_snippet.should == "def type_user_name(input)\n  page.fill_in(\"User-Name\", with: input)\nend"
          end
        end
      end

      context "when the type is button" do
        let(:type) { :button }
        context "when the name and the selector are present" do
          it "returns the method's snippet" do
            element = Swamp::Button.new("Log_in", "Log_in")
            builder = Swamp::Builder.new(element)
            builder.build_snippet.should == "def log_in\n  page.click_button(\"Log_in\")\nend"
          end
        end

        context "when just the selector is present" do
          it "returns just the selector snippet" do
            element = Swamp::Button.new(nil, "$ 9.90 Buy")
            builder = Swamp::Builder.new(element)
            builder.build_snippet.should == "page.click_button(\"$ 9.90 Buy\")"
          end
        end
      end
    end
  end
end
