module Monadist
  class List < Monad

    attr_reader :values



    def initialize(*values)
      @values = values
    end



    def bind(&block)
      self.class.unit *values.map(&block).flat_map(&:values)
    end



    def +(list)
      self.class.unit *(values + list.values)
    end



    def self.unit(*values)
      new *values
    end

  end
end
