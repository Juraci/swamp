require 'spec_helper'
module  Swamp
  describe Wrapper do
    let(:fields) { fields = double('fields') }
    let(:wrapper) { wrapper = Swamp::Wrapper.new(fields) }

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

      context "when elements were found" do
        it "formats the elements to code snippets" do
          fields.stub(:get).and_return(["username", "password"])
          wrapper.scan.should == ["def type_username(input)\n  source.fill_in(\"username\", with: input)\nend", "def type_password(input)\n  source.fill_in(\"password\", with: input)\nend"]
        end

        context "when the method name has dashes" do
          it "replace the dashes with unsderscore" do
            fields.stub(:get).and_return(["user-name"])
            wrapper.scan.should == ["def type_user_name(input)\n  source.fill_in(\"user-name\", with: input)\nend"]
          end
        end

        context "when the method name has white spaces" do
          it "replace the white spaces with unsderscore" do
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
