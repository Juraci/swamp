require 'spec_helper'
module Swamp
  describe Formatter do
    let(:formatter) { formatter = Swamp::Formatter.new }

    describe "#format" do
      context "when the name has dashes" do
        it "replaces the dashes with unsderscores" do
          name = "user-name"
          formatter.format(name).should == "user_name"
        end
      end

      context "when the name has white spaces" do
        it "replaces the white spaces with unsderscores" do
          name = "user name"
          formatter.format(name).should == "user_name"
        end
      end

      context "when the name has underscore in the end" do
        it "removes the underscores from the end" do
          name = "user_name_"
          formatter.format(name).should == "user_name"
        end
      end

      context "when the name has uppercase characters" do
        it "converts the characters to lowercase" do
          name = "Sign up"
          formatter.format(name).should == "sign_up"
        end
      end
    end
  end
end
