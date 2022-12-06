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
  pos = CartesianIndex{2}[]
  for i in 2:size(map)[1]-1
    for j in 2:size(map)[2]-1
      is_min = 0
      is_min += map[i, j] < map[i-1, j]
      is_min += map[i, j] < map[i+1, j]
      is_min += map[i, j] < map[i, j+1]
      is_min += map[i, j] < map[i, j-1]
      if is_min == 4
        push!(res, map[i, j])
        push!(pos, CartesianIndex(i, j))
      end
    end
  end
  return res, pos
end

function calc_basin(map, p, dict)
  if map[p] != 9 && !haskey(dict, p)
    dict[p] = map[p]
    calc_basin(map, p-CartesianIndex(1, 0), dict)
    calc_basin(map, p-CartesianIndex(-1, 0), dict)
    calc_basin(map, p-CartesianIndex(0, 1), dict)
    calc_basin(map, p-CartesianIndex(0, -1), dict)
  end
end

function calc_basins(map, pos)
  basins = Int32[]
  for p in pos
    dict = Dict{CartesianIndex{2}, Int32}()
    calc_basin(map, p, dict)
    basin_size = length(values(dict))
    push!(basins, basin_size)
  end
  sort!(basins)
  return basins[end] * basins[end-1] * basins[end-2], basins
end

mins, pos = findMin(map)
res, basins = calc_basins(map, pos)

println(res)


