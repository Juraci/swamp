require 'spec_helper'

module Swamp
  module Builders
    describe Prism do
      let(:builder) { Swamp::Builders::Prism.new }

      describe "#build_snippet" do
        it "returns the method's snippet" do
          element = Swamp::Button.new("User-Name", "User-Name")
          element.prism_selector = "'#User-Name'"
          expect(builder.build_snippet(element)).to eq("element :user_name, '#User-Name'")
        end
      end
    end
  end
end