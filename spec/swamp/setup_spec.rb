require 'spec_helper'
module Swamp
  describe Setup do
    let(:setup) { Swamp::Setup.new }

    it "should set the default options" do
      setup.scope.should == "page"
    end

    describe "#handle_command" do
      context "when the command is valid" do
        context "when the scope is changed" do
          it "should set the option :scope to source" do
            setup.handle_command(":scope = source")
            setup.scope.should == "source"
          end

          it "should return a message confirming the scope was setted to source" do
            setup.handle_command(":scope = source").should == ["Option :scope setted to source"]
          end

          it "should set the option :scope to page" do
            setup.handle_command(":scope = page")
            setup.scope.should == "page"
          end

          it "should return a message confirming the scope was setted to page" do
            setup.handle_command(":scope = page").should == ["Option :scope setted to page"]
          end
        end

      end
    end

  end
end
