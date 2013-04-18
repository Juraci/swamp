require 'spec_helper'

module Swamp
  describe Initializer do

      let(:output) { output = double('output').as_null_object }
      let(:initializer) { initializer = Initializer.new(output) }

      describe "#run" do
        it "prompts for the url" do
          output.should_receive(:puts).with("Enter the url for the page to be scanned:")
          initializer.run
        end
      end

      describe "delegates to the finder the parsing of the page" do
        pending "How to delegate the dependencies?"
        #scanner = double('a scanner')
        #scanner.should_receive(:visit).with('www.google.com')

        #initializer = Initializer.new(output, scanner)
        #initializer.scan('www.google.com')
      end

      describe "#present" do
        it "sends the snippets to the output" do
          initializer.run
          snippets = ["def" + " " + "type_" + "username" + "(" + "input" + ")" + "\n" + "  " + "source.fill_in(\"" + "username" + "\", with: input)\nend"]
          initializer.stub(:scan).and_return(snippets)
          output.should_receive(:puts).with("def type_username(input)\n  source.fill_in(\"username\", with: input)\nend")
          initializer.present(snippets)
        end
      end

  end
end
