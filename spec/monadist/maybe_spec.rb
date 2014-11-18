require 'spec_helper'

module Monadist
  describe Maybe do

    describe ".unit" do
      it "returns a monad wrapping the specified value" do
        result = Maybe.unit "value"

        expect(result).to be_a Maybe
        expect(result.value).to eq "value"
      end
    end


    describe "#value" do
      it "returns the value wrapped by the monad" do
        expect(Maybe.unit("value").value).to eq "value"
      end
    end


    describe "#bind" do
      context "when wrapping nil" do
        subject { Maybe.unit nil }

        it "doesn't execute the passed block" do
          expect { |block| subject.bind &block }.not_to yield_control
        end

        it "returns a monad wrapping nil" do
          result = subject.bind {}

          expect(result).to be_a Maybe
          expect(result.value).to be_nil
        end
      end

      context "when wrapping a non-nil value" do
        subject { Maybe.unit "some value" }

        it "calls the passed block with the value" do
          expect { |block| subject.bind &block }.to yield_with_args "some value"
        end

        it "returns the block's result" do
          result = subject.bind { |_| Maybe.unit "new value" }

          expect(result).to be_a Maybe
          expect(result.value).to eq "new value"
        end
      end
    end


    context "when wrapping a non-nil value" do
      it "forwards messages directly to the wrapped value and returns a monad wrapping the result" do
        result = Maybe.unit("test").length

        expect(result).to be_a Maybe
        expect(result.value).to eq 4
      end
    end


    context "when wrapping nil" do
      it "disregards all messages and returns a monad wrapping nil" do
        result = Maybe.unit(nil).concat('some')[:property] + 1

        expect(result).to be_a Maybe
        expect(result.value).to be_nil
      end
    end

  end
end
