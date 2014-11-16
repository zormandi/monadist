module Monadist
  class Monad

    def join
      bind do |value|
        raise "Wrapped value not a monad of type #{self.class.name}" unless value.instance_of? self.class
        value
      end
    end



    def fmap(&block)
      bind { |value| self.class.unit block.call value }
    end



    def method_missing(*args, &block)
      fmap { |value| value.public_send *args, &block }
    end

  end
end
