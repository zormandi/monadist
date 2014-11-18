module Monadist
  class Continuation < Monad

    def initialize(&block)
      @block = block
    end



    def bind(&block)
      self.class.new do |next_block|
        run do |value|
          block.call(value).run(&next_block)
        end
      end
    end



    def run(&block)
      @block.call(block || lambda { |value| value })
    end



    def self.unit(value)
      new { |next_block| next_block.call value }
    end

  end
end
