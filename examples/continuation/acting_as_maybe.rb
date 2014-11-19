require 'monadist'

words = %w[apple tree]

p Monadist::Continuation.unit(words).
    fmap { |array| array.map &:length }.
    run


words = nil



def maybe(value)
  Monadist::Continuation.new { |next_block| next_block.call value unless value.nil? }
end



p maybe(words).
    fmap { |array| array.map &:length }.
    run
