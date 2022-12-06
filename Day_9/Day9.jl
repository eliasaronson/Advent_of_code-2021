using BenchmarkTools
inp = open("$(@__DIR__)/input.txt")

input = readlines(inp)

map = Matrix{Int32}(undef, size(input)[1]+2, length(input[1])+2)
map .= 9

for (idx, l) in enumerate(input)
  map[idx+1, 2:end-1] = parse.(Int32, collect(l))
end

function findMin(map)
  res = []
  for i in 2:size(map)[1]-1
    for j in 2:size(map)[2]-1
      is_min = 0
      is_min += map[i, j] < map[i-1, j]
      is_min += map[i, j] < map[i+1, j]
      is_min += map[i, j] < map[i, j+1]
      is_min += map[i, j] < map[i, j-1]
      if is_min == 4
        push!(res, map[i, j])
      end
    end
  end
  return res
end

mins = findMin(map)
risk_level = sum(mins .+ 1)
println(risk_level)

