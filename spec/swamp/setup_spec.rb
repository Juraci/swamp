require 'spec_helper'
module Swamp
  describe Setup do
    let(:setup) { Swamp::Setup.new }

    it "should set the default options" do
      expect(setup.scope).to eq("page")
    end

    describe "#handle_command" do
      context "when the command is valid" do
        context "when the scope changes" do
          it "should set the option :scope to source" do
            setup.handle_command(":scope = source")
            expect(setup.scope).to eq("source")
          end

          it "should return a message confirming the scope was setted to source" do
            expect(setup.handle_command(":scope = source")).to eq(["Option :scope setted to source"])
          end

          it "should set the option :scope to page" do
            setup.handle_command(":scope = page")
            expect(setup.scope).to eq("page")
          end

          it "should return a message confirming the scope was setted to page" do
            expect(setup.handle_command(":scope = page")).to eq(["Option :scope setted to page"])
          end
        end
      end

      context "when the command is invalid" do
        it "should return a message warning that the command is invalid" do
          expect(setup.handle_command(":scope = ")).to eq(["Invalid command"])
        end
      end
    end

  end
end
