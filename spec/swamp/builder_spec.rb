require 'spec_helper'
module Swamp
  describe Builder do
    let(:builder) { Swamp::Builder.new('page') }
    let(:source_builder) { Swamp::Builder.new('source') }

    describe "#build_method" do
      context "when the type is field" do
        context "when the name and the selector are present" do
          it "returns the method's snippet" do
            element = Swamp::Field.new("User-Name", "User-Name")
            expect(builder.build_snippet(element)).to eq("def type_user_name(input)\n  page.fill_in(\"User-Name\", with: input)\nend")
          end
        end
      end

      context "when the type is button" do
        context "when the name and the selector are present" do
          it "returns the method's snippet" do
            element = Swamp::Button.new("Log_in", "Log_in")
            expect(builder.build_snippet(element)).to eq("def log_in\n  page.click_button(\"Log_in\")\nend")
          end
        end

        context "when just the selector is present" do
          it "returns just the selector snippet" do
            element = Swamp::Button.new(nil, "$ 9.90 Buy")
            expect(builder.build_snippet(element)).to eq("page.click_button(\"$ 9.90 Buy\")")
          end
        end

        context "when the scope has changed" do
          it "returns the method's snippet with the changed scope" do
            element = Swamp::Button.new("Log_in", "Log_in")
            expect(source_builder.build_snippet(element)).to eq("def log_in\n  source.click_button(\"Log_in\")\nend")
          end
        end

      end
    end
  end
end
