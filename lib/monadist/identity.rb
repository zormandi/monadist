module Monadist
  class Identity < Monad

    attr_reader :value



    def initialize(value)
      @value = value
    end



    def bind(&block)
      block.call value
    end



    def self.unit(value)
      new value
    end

  end
end
