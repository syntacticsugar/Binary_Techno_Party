def reduce( accumulator, sequence, &operation )
  for element in sequence
    accumulator = operation[accumulator, element]
  end
  accumulator
end

def map( sequence, &operation )
  reduce( [], sequence ) { |accumulator, element| accumulator << operation[element] }
end

def filter( sequence, &condition )
  reduce( [], sequence ) do |accumulator, element|
    condition[element] ? accumulator << element : accumulator
  end
end

# reduce( initial, [], operation )
