require 'spec_helper'

module Monadist
  describe Identity do

    describe ".unit" do
      it "should return a monad wrapping the specified value" do
        result = Identity.unit "value"

        expect(result).to be_an Identity
        expect(result.value).to eq "value"
      end
    end


    describe "#value" do
      it "should return the value wrapped by the monad" do
        expect(Identity.unit("value").value).to eq "value"
      end
    end


    describe "#bind" do
      it "should call the passed block with the value" do
        expect { |block| Identity.unit("some value").bind &block }.to yield_with_args "some value"
      end
    end


    it "should allow sending messages directly to the wrapped value" do
      result = Identity.unit("test").length

      expect(result).to be_an Identity
      expect(result.value).to eq 4
    end

  end
end
