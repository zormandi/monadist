require 'spec_helper'

module Monadist
  describe List do

    describe ".unit" do
      it "should return a monad wrapping the specified value" do
        result = List.unit "value"

        expect(result).to be_a List
        expect(result.values).to eq ["value"]
      end

      it "should accept multiple parameters and pass them into the monad as separate values, not as an array" do
        expect(List.unit("value1", "value2").values).to eq %w[value1 value2]
      end
    end


    describe "#values" do
      it "should return the value(s) wrapped by the monad as an array" do
        expect(List.unit("value").values).to eq %w[value]
      end
    end


    describe "#bind" do
      it "should call the passed block with each value wrapped by the monad and return a monad wrapping the resulting values" do
        subject = List.unit 1, 2, 3

        result = subject.bind { |value| List.unit(value * 10) }

        expect(result).to be_a List
        expect(result.values).to eq [10, 20, 30]
      end

      it "should handle array values without flattening or nesting them" do
        subject = List.unit [1, 2], [3, 4]

        result = subject.bind { |value| List.unit value }

        expect(result.values).to eq [[1, 2], [3, 4]]
      end
    end


    it "should forward messages to all the values it contains" do
      headers = %w[HTTP_HOST HTTP_CONTENT_TYPE HTTP_DATE]
      subject = List.unit *headers

      expect(subject[5..-1].tr("_", "-").capitalize.values).to eq %w[Host Content-type Date]
    end


    describe "#+" do
      it "should concatenate two lists and return the resulting monad" do
        concatenated_list = List.unit(1, 2) + List.unit(3, 4)

        expect(concatenated_list).to be_a List
        expect(concatenated_list.values).to eq [1, 2, 3, 4]
      end
    end

  end
end
