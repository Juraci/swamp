require 'spec_helper'
module Swamp
  describe Setup do
    let(:setup) { Swamp::Setup.new }
    let(:source_scope) { Swamp::Scope::Source.new }
    let(:page_scope) { Swamp::Scope::Page.new }

    before :each do
      allow(Swamp::Scope).to receive(:from_value).with('source').and_return(source_scope)
      allow(Swamp::Scope).to receive(:from_value).with('page').and_return(page_scope)
    end

    it "should set the default options" do
      expect(setup.scope).to eq(page_scope)
    end

    describe "#handle_command" do
      context "when the command is valid" do
        context "when the scope changes" do
          it "should set the option :scope" do
            setup.handle_command(":scope = source")
            expect(setup.scope).to eq(source_scope)
          end

          it "should return a message confirming the scope was set to source" do
            expect(setup.handle_command(":scope = source")).to eq(["Option :scope set to source"])
          end

          it "should set the option :scope to page" do
            setup.handle_command(":scope = page")
            expect(setup.scope).to eq(page_scope)
          end

          it "should return a message confirming the scope was set to page" do
            expect(setup.handle_command(":scope = page")).to eq(["Option :scope set to page"])
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
