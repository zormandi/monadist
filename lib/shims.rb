def possibly_nil(value)
  Monadist::Maybe.unit value
end



def list(*values)
  Monadist::List.unit *values
end



def with(value)
  Monadist::Continuation.unit value
end



def meanwhile_with(value)
  Monadist::Meanwhile.unit value
end
