require 'monadist'

puts Monadist::Identity.unit("Hello").
  bind { |value| Monadist::Identity.unit value + " world!" }.
  value

