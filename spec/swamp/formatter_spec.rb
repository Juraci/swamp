require 'spec_helper'
module Swamp
  describe Formatter do
    let(:formatter) { formatter = Swamp::Formatter.new }

    describe "#format" do
      context "when the name has dashes" do
        it "replaces the dashes with unsderscores" do
          name = "user-name"
          expect(formatter.format(name)).to eq("user_name")
        end
      end

      context "when the name has white spaces" do
        it "replaces the white spaces with underscores" do
          name = "user name"
          expect(formatter.format(name)).to eq("user_name")
        end
      end

      context "when the name has underscore in the end" do
        it "removes the underscores from the end" do
          name = "user_name_"
          expect(formatter.format(name)).to eq("user_name")
        end
      end

      context "when the name has uppercase characters" do
        it "converts the characters to lowercase" do
          name = "Sign up"
          expect(formatter.format(name)).to eq("sign_up")
        end
      end

      context "when the name has parentheses" do
        it "replace the parentheses with underscores" do
          name = "user_name(title)"
          expect(formatter.format(name)).to eq("user_name_title")
        end
      end

      context "when the name has brackets" do
        it "replace the brackets with underscores" do
          name = "user_name[title]"
          expect(formatter.format(name)).to eq("user_name_title")
        end
      end
    end

    describe "#format_class" do
      context "when the class has white spaces" do
        it "replaces the white spaces with dots" do
          class_name = "button g-button g-button-submit"
          expect(formatter.format_class(class_name)).to eq("button.g-button.g-button-submit")
        end
      end
    end
  end
end
