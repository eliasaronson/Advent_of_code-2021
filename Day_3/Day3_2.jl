inp = open("$(@__DIR__)/input.txt")
input = readlines(inp)

input = split.(input, "")

n_sum = zeros(length(input[1]))

function find_param(input, typ)
  for i in 1:length(input[1])
    if length(input) == 1
      break
    end

    n_one = 0
    for num in input
      num = parse.(Int32, num)
      n_one += num[i]
    end

    filt = n_one >= length(input)/2 ? typ[1] : typ[2]

    filter!(x -> x[i] == filt, input)
  end
  return parse(Int32, join(input[1]), base=2)
end

O₂ = find_param(copy(input), ("1", "0"))
CO₂ = find_param(copy(input), ("0", "1"))

println(O₂ * CO₂)
