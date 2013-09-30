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
      it "warns the user that it is scanning" do
        output.should_receive(:puts).with("Scanning, please wait...")
        interface.scan("http://www.fakepage.com")
      end

      it "delegates the responsibility to fire up the browser to the wrapper class" do
        wrapper.should_receive(:explore)
        interface.scan("http://www.fakepage.com")
      end

      it "delegates the page parsing to the wrapper class" do
        wrapper.should_receive(:scan).and_return(["code_snippet"])
        interface.scan("http://www.fakepage.com")
      end

      context "when it scans a valid url" do
        it "sends the code snippets of the scanned page to the output" do
          wrapper.stub(:scan).and_return(["code_snippet"])
          output.should_receive(:puts).with("code_snippet")
          interface.scan("http://www.fakepage.com")
        end
      end

      context "when it scans an invalid url" do
        it "sends a warning message to the output" do
          output.should_receive(:puts).with("Please enter a valid url!")
          interface.scan("abc123")
        end
      end

      context "when it receives an enter keystroke" do
        context "when no page was scanned yet" do
          it "sends a warning message to the output" do
            wrapper.stub(:page_visited).and_return(false)
            output.should_receive(:puts).with("Please enter a valid url!")
            interface.scan("\n")
          end
        end

        context "when a page was already scanned" do
          it "scans the current page and sends the code snippets to the output" do
            wrapper.stub(:page_visited).and_return(true)
            wrapper.stub(:scan).and_return(["code_snippet"])
            output.should_receive(:puts).with("code_snippet")
            interface.scan("\n")
          end
        end
      end

    end
  end
end
