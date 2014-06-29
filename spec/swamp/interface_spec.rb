require 'spec_helper'
module Swamp
  describe Interface do
    let(:output) { output = double('output').as_null_object }
    let(:wrapper) { wrapper = double('wrapper').as_null_object }
    let(:setup) { setup = Swamp::Setup.new }
    let(:interface) { interface = Swamp::Interface.new(output, wrapper, setup) }

    describe "#run" do
      it "prompts for the url" do
        expect(output).to receive(:puts).with("Enter the url for the page to be scanned:")
        interface.run
      end
    end

    describe "#setup_command" do
      let(:command) { ":scope = source" }
      it "delegates the responsibility to execute the command to the Setup class" do
        expect(setup).to receive(:handle_command).with(command).and_return(["something"])
        interface.setup_command(command)
      end

      context "when it receives a valid command" do
        it "sends a message to the output telling that the command was successful" do
          expect(output).to receive(:puts).with("Option :scope setted to source")
          interface.setup_command(command)
        end
      end
    end

    describe "#scan" do
      it "warns the user that it is scanning" do
        expect(output).to receive(:puts).with("Scanning, please wait...")
        interface.scan("http://www.fakepage.com")
      end

      it "delegates the responsibility to fire up the browser to the wrapper class" do
        expect(wrapper).to receive(:explore)
        interface.scan("http://www.fakepage.com")
      end

      it "delegates the page parsing to the wrapper class" do
        expect(wrapper).to receive(:scan).and_return(["code_snippet"])
        interface.scan("http://www.fakepage.com")
      end

      context "when it scans a valid url" do
        context "when elements were found" do
          it "sends the code snippets of the scanned page to the output" do
            allow(wrapper).to receive(:scan).and_return(["code_snippet"])
            expect(output).to receive(:puts).with("code_snippet")
            interface.scan("http://www.fakepage.com")
          end
        end

        context "when no elements were found" do
          it "sends a warning message to the output telling that no elements were found" do
            allow(wrapper).to receive(:scan).and_return([])
            expect(output).to receive(:puts).with("No elements were detected")
            interface.scan("http://www.fakepage.com")
          end
        end
      end

      context "when it scans an invalid url" do
        it "sends a warning message to the output" do
          expect(output).to receive(:puts).with("Please enter a valid url!")
          interface.scan("abc123")
        end
      end

      context "when it receives an enter keystroke" do
        context "when no page was scanned yet" do
          it "sends a warning message to the output" do
            allow(wrapper).to receive(:page_visited).and_return(false)
            expect(output).to receive(:puts).with("Please enter a valid url!")
            interface.scan("\n")
          end
        end

        context "when a page was already scanned" do
          it "scans the current page and sends the code snippets to the output" do
            allow(wrapper).to receive(:page_visited).and_return(true)
            allow(wrapper).to receive(:scan).and_return(["code_snippet"])
            expect(output).to receive(:puts).with("code_snippet")
            interface.scan("\n")
          end
        end
      end

    end
  end
end
