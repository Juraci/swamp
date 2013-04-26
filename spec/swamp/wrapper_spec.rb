require 'spec_helper'
module  Swamp
  describe Wrapper do
    let(:fields) { fields = double('fields').as_null_object }
    let(:buttons) { buttons = double('buttons').as_null_object }
    let(:wrapper) { wrapper = Swamp::Wrapper.new(fields, buttons) }

    describe "#explore" do
      it "fires up the browser to a given url" do
        url = "www.fakepage.com"
        wrapper.should_receive(:visit).with(url).and_return("")
        wrapper.explore(url)
      end
    end

    describe "#scan" do
      it "delegates the parsing of the fields to the fields class" do
        fields.should_receive(:get).and_return(["username"])
        wrapper.scan
      end

      it "delegates the parsing of the buttons to the buttons class" do
        buttons.should_receive(:get).and_return(["log_in"])
        wrapper.scan
      end

      context "when elements were found" do
        it "formats the elements to code snippets" do
          fields.stub(:get).and_return(["username", "password"])
          wrapper.scan.should == ["def type_username(input)\n  source.fill_in(\"username\", with: input)\nend", "def type_password(input)\n  source.fill_in(\"password\", with: input)\nend"]
        end

        context "when the method name has dashes" do
          it "replaces the dashes with unsderscore" do
            fields.stub(:get).and_return(["user-name"])
            wrapper.scan.should == ["def type_user_name(input)\n  source.fill_in(\"user-name\", with: input)\nend"]
          end
        end

        context "when the method name has white spaces" do
          it "replaces the white spaces with unsderscore" do
            fields.stub(:get).and_return(["user name"])
            wrapper.scan.should == ["def type_user_name(input)\n  source.fill_in(\"user name\", with: input)\nend"]
          end
        end

        context "when the method name has underscore in the end" do
          it "removes the underscores from the end" do
            fields.stub(:get).and_return(["user_name_"])
            wrapper.scan.should == ["def type_user_name(input)\n  source.fill_in(\"user_name_\", with: input)\nend"]
          end
        end

        context "when the method name has uppercase characters" do
          it "converts the characters to lowercase" do
            buttons.stub(:get).and_return(["Sign up"])
            wrapper.scan.should == ["def sign_up\n  source.click_button(\"Sign up\")\nend"]
          end
        end
      end

      context "when no elements were found" do
        it "returns an empty array" do
          fields.stub(:get).and_return([])
          wrapper.scan.should == []
        end
      end
    end
  end
end
