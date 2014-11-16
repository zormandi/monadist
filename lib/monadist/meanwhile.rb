module Monadist
  class Meanwhile < Continuation

    def bind(&block)
      self.class.new do |next_block|
        Thread.new do
          run do |value|
            block.call(value).run(&next_block)
          end
        end
      end
    end

  end
end
