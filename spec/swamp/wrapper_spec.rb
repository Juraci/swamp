require 'spec_helper'
module Swamp
  describe Wrapper do
    let(:setup) { setup = Swamp::Setup.new }

    describe '#explore' do
      it 'fires up the browser to a given url' do
        url = 'www.fakepage.com'
        meta_collection = []
        wrapper = Swamp::Wrapper.new(meta_collection, setup)
        expect(wrapper).to receive(:visit).with(url).and_return("")
        wrapper.explore(url)
      end
    end

    describe '#scan' do
      let(:fields) { double('fields').as_null_object }
      let(:buttons) { double('buttons').as_null_object }
      let(:input_buttons) { double('input_buttons').as_null_object }
      let(:select_boxes) { double('select_boxes').as_null_object }
      let(:links) { double('links').as_null_object }
      let(:generic_element_collection) { double('generic_element_collection').as_null_object }

      it'delegates the responsibility of getting the elements for each element collection object' do
        meta_collection = [generic_element_collection]
        wrapper = Swamp::Wrapper.new(meta_collection, setup)
        meta_collection.each { |element_collection| expect(element_collection).to receive(:get).and_return([]) }
        wrapper.scan
      end

      context "when field elements were found" do
        let(:field) { Swamp::Field.new("username", "username") }

        it "returns an array of formatted code snippets for fields" do
          allow(fields).to receive(:get).and_return([field])

          meta_collection = [fields]
          wrapper = Swamp::Wrapper.new(meta_collection, setup)
          expect(wrapper.scan).to eq(["def type_username(input)\n  page.fill_in(\"username\", with: input)\nend"])
        end
      end

      context 'when button elements were found' do
        let(:button) { Swamp::Button.new('log_in', 'log_in') }

        it 'returns an array of formatted code snippets for buttons' do
          allow(buttons).to receive(:get).and_return([button])

          meta_collection = [buttons]
          wrapper = Swamp::Wrapper.new(meta_collection, setup)
          expect(wrapper.scan).to eq(["def log_in\n  page.click_button(\"log_in\")\nend"])
        end
      end

      context'when input button elements were found' do
        let(:input_button) { Swamp::InputButton.new("Log In", "input#u_0_b") }

        it 'returns an array of formatted code snippets for input buttons' do
          allow(input_buttons).to receive(:get).and_return([input_button])

          meta_collection = [input_buttons]
          wrapper = Swamp::Wrapper.new(meta_collection, setup)
          expect(wrapper.scan).to eq(["def log_in\n  page.find(:css, \"input#u_0_b\").click\nend"])
        end
      end

      context 'when select box elements were found' do
        let(:select_box) { Swamp::SelectBox.new('month', 'month') }

        it 'returns an array of formatted code snippets for select boxes' do
          allow(select_boxes).to receive(:get).and_return([select_box])

          meta_collection = [select_boxes]
          wrapper = Swamp::Wrapper.new(meta_collection, setup)
          expect(wrapper.scan).to eq(["def select_month(option)\n  page.select(option, :from => \"month\")\nend"])
        end
      end

      context 'when links were found' do
        let(:link) { Swamp::Link.new('forgot-password', 'forgot-password') }

        it' "returns an array of formatted code snippets for links"' do
          allow(links).to receive(:get).and_return([link])

          meta_collection = [links]
          wrapper = Swamp::Wrapper.new(meta_collection, setup)
          expect(wrapper.scan).to eq(["def forgot_password\n  page.click_link(\"forgot-password\")\nend"])
        end
      end

      context 'when no elements were found' do
        it 'returns an empty array' do
          allow(fields).to receive(:get).and_return([])
          allow(buttons).to receive(:get).and_return([])
          allow(input_buttons).to receive(:get).and_return([])
          allow(select_boxes).to receive(:get).and_return([])
          allow(links).to receive(:get).and_return([])

          meta_collection = [fields, buttons, input_buttons, select_boxes]
          wrapper = Swamp::Wrapper.new(meta_collection, setup)
          expect(wrapper.scan).to eq([])
        end
      end
    end
  end
end
