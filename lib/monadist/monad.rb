module Monadist
  class Monad

    def join
      #TODO
    end



    def fmap(&block)
      bind { |value| self.class.unit block.call value }
    end



    def method_missing(*args, &block)
      fmap { |value| value.public_send *args, &block }
    end

  end
end
