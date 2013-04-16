require 'spec_helper'

module Swamp
  describe Initializer do

      let(:output) { output = double('output').as_null_object }
      let(:initializer) { initializer = Initializer.new(output) }

      describe "#run" do
        it "prompts for the url" do
          output.should_receive(:puts).with('Enter the url for the page to be scanned:')
          initializer.run
        end
      end
  end
end
