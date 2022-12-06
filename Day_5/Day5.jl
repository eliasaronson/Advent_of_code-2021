using BenchmarkTools
inp = open("$(@__DIR__)/input.txt")

input = read(inp, String)
coords = [m.match for m = eachmatch(r"\d+", input)]
coords = parse.(Int32, coords)
coords = permutedims(reshape(coords, 4, length(coords)÷4))
coords = coords[(coords[:, 1] .== coords[:, 3]) .| (coords[:, 2] .== coords[:, 4]), :] .+1

board = zeros(max(maximum(coords[:, 1]), maximum(coords[:, 3])), max(maximum(coords[:, 2]), maximum(coords[:, 4])))

for c in 1:size(coords)[1]
  if coords[c, 1] > coords[c, 3]
    tmp = coords[c, 1]
    coords[c, 1] = coords[c, 3]
    coords[c, 3] = tmp
  elseif coords[c, 2] > coords[c, 4]  
    tmp = coords[c, 2]
    coords[c, 2] = coords[c, 4]
    coords[c, 4] = tmp
  end

  board[coords[c, 1]:coords[c, 3], coords[c, 2]:coords[c, 4]] = board[coords[c, 1]:coords[c, 3], coords[c, 2]:coords[c, 4]] .+ 1
end

res = sum(board .> 1)

println(res)
