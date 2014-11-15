module Monadist
  class Maybe < Monad

    attr_reader :value



    def initialize(value)
      @value = value
    end



    def bind(&block)
      return self if value.nil?

      block.call value
    end



    def self.unit(value)
      new value
    end

  end
end
