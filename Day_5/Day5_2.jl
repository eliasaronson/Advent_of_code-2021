using BenchmarkTools, LinearAlgebra
inp = open("$(@__DIR__)/input.txt")

input = read(inp, String)
coords = [m.match for m = eachmatch(r"\d+", input)]
coords = parse.(Int32, coords)
coords = permutedims(reshape(coords, 4, length(coords)÷4))
coords_dia = copy(coords).+10
coords = coords[(coords[:, 1] .== coords[:, 3]) .| (coords[:, 2] .== coords[:, 4]), :] .+10
#coords_dia = coords_dia[(coords_dia[:, 1] .!= coords_dia[:, 3]) .& (coords_dia[:, 2] .!= coords_dia[:, 4]), :] .+1

board = zeros(max(maximum(coords[:, 1]), maximum(coords[:, 3]))+1000, max(maximum(coords[:, 2]), maximum(coords[:, 4]))+1000)

println(coords_dia)

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

for c in 1:size(coords_dia)[1]
  if !(coords_dia[c, 1] == coords_dia[c, 3] || coords_dia[c, 2] == coords_dia[c, 4])
    x_0 = coords_dia[c, 1]
    y_0 = coords_dia[c, 2]
    x = 0
    y = 0
    x_sign = coords_dia[c, 1] > coords_dia[c, 2] ? -1 : 1
    y_sign = coords_dia[c, 2] > coords_dia[c, 4] ? -1 : 1
    for i in 1:abs(coords_dia[c, 3] - coords_dia[c, 1])
      board[x_0+x, y_0+y] += 1
      x += x_sign
      y += y_sign
      if x_0 + x < 1
        x += 1
      end
      if y_0 + y < 1
        y += 1
      end
    end
  end
end

res = sum(board .> 1)

println(res)
