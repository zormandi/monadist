def possibly_nil(value)
  Monadist::Maybe.unit value
end



def list(value)
  Monadist::List.unit value
end



def with(value)
  Monadist::Continuation.unit value
end



def meanwhile_with(value)
  Monadist::Meanwhile.unit value
end
