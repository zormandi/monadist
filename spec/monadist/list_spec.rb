require 'spec_helper'

module Monadist
  describe List do

    describe ".unit" do
      it "returns a monad wrapping the specified value" do
        result = List.unit "value"

        expect(result).to be_a List
        expect(result.values).to eq ["value"]
      end

      it "treats arrays as a list of values (for convenience)" do
        expect(List.unit(%w(value1 value2)).values).to eq %w[value1 value2]
      end
    end


    describe "#values" do
      it "returns the value(s) wrapped by the monad as an array" do
        expect(List.unit("value").values).to eq %w[value]
      end
    end


    describe "#bind" do
      it "calls the passed block with each value wrapped by the monad and returns a monad wrapping the resulting values" do
        subject = List.unit [1, 2, 3]

        result = subject.bind { |value| List.unit(value * 10) }

        expect(result).to be_a List
        expect(result.values).to eq [10, 20, 30]
      end

      it "handles array values without flattening or nesting them" do
        subject = List.unit [[1, 2], [3, 4]]

        result = subject.bind { |value| List.unit [value] }

        expect(result.values).to eq [[1, 2], [3, 4]]
      end
    end


    it "forwards messages to all the values it contains" do
      subject = List.unit %w[HTTP_HOST HTTP_CONTENT_TYPE HTTP_DATE]

      expect(subject[5..-1].tr("_", "-").capitalize.values).to eq %w[Host Content-type Date]
    end

  end
end
