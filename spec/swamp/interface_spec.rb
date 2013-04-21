require 'spec_helper'
module Swamp
  describe Interface do

    let(:output) { output = double('output').as_null_object }
    let(:wrapper) { wrapper = double('wrapper').as_null_object }
    let(:interface) { interface = Swamp::Interface.new(output, wrapper) }

    describe "#run" do
      it "prompts for the url" do
        output.should_receive(:puts).with("Enter the url for the page to be scanned:")
        interface.run
      end
    end

    describe "#scan" do
      it "delegates the responsibility to fire up the browser to the wrapper class" do
        wrapper.should_receive(:explore)
        interface.scan("fakepage.com")
      end

      it "delegates the page parsing to the wrapper class" do
        wrapper.should_receive(:scan).and_return(["code_snippet"])
        interface.scan("fakepage.com")
      end

      it "sends the code snippets of the scanned page to the output" do
        wrapper.stub(:scan).and_return(["code_snippet"])
        output.should_receive(:puts).with("code_snippet")
        interface.scan("fakepage.com")
      end
    end
  end
end
