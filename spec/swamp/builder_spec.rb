require 'spec_helper'
module Swamp
  describe Builder do
    describe "#build_method" do
      context "when type is field" do
        let(:type) { :field }
        context "when the name and the selector are present" do
          it "returns the method's snippet" do
            builder = Swamp::Builder.new(type, "User-Name", "User-Name")
            builder.build_method.should == "def type_user_name(input)\n  source.fill_in(\"User-Name\", with: input)\nend"
          end
        end
      end

      context "when type is button" do
        let(:type) { :button }
        context "when the name and the selector are present" do
          it "returns the method's snippet" do
            builder = Swamp::Builder.new(type, "Log_in", "Log_in")
            builder.build_method.should == "def log_in\n  source.click_button(\"Log_in\")\nend"
          end
        end

        context "when just the selector is present" do
          it "returns just the selector snippet" do
            builder = Swamp::Builder.new(type, nil, "$ 9.90 Buy")
            builder.build_method.should == "source.click_button(\"$ 9.90 Buy\")"
          end
        end
      end
    end
  end
end
