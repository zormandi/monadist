def possibly_nil(value)
  Monadist::Maybe.unit value
end

def many(*values)
  Monadist::List.unit *values
end
