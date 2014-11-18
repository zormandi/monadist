module Monadist
  class List < Monad

    attr_reader :values



    def initialize(values)
      @values = values
    end



    def bind(&block)
      self.class.new values.map(&block).flat_map(&:values)
    end



    def self.unit(value)
      if value.is_a? Array
        new value
      else
        new [value]
      end
    end

  end
end
