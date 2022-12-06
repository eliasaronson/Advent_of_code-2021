using BenchmarkTools, Graphs, GraphPlot, MetaGraphs, DelimitedFiles
inp = open("$(@__DIR__)/test_input.txt")

input = read(inp, String)

dots, folds = split(input, "\n\n")
dots = split(dots, "\n")
dots = split.(dots, ",")
folds = split(folds, "\n")

dots_x = []
dots_y = []

for d in dots
  d = parse.(Int32, d) .+ 1
  push!(dots_x, d[1])
  push!(dots_y, d[2])
end

map = zeros(maximum(dots_x), maximum(dots_y))

for d in dots
  d = parse.(Int32, d) .+ 1
  map[d[1], d[2]] = 1
end

display(map)

x, y = size(map)

for fold in folds
  if fold == ""
    break
  end
  println(fold)
  m1 = match(r"\d+", fold)
  m2 = match(r"[y|x]", fold)
  fold_line = parse(Int32, m1.match) + 1
  println(fold_line)
  if m2.match == "x"
    fold_len = fold_line - 1 - (x - fold_line - 1)
    println(fold_len)
    map[fold_len:fold_line-1, :] .+= reverse(map[fold_line+1:end, :], dims=1)
    global map = map[fold_len:fold_line-1, :]
  else
    fold_len = fold_line - 1 - (y - fold_line - 1)
    println(fold_len)
    map[:, fold_len:fold_line-1] .+= reverse(map[:, fold_line+1:end], dims=2)
    global map = map[:, 1:fold_line-1]
  end
  global x, y = size(map)
  display(map)
  println(size(map))
end


display(map)
println(folds)
#println(dots)
non_zero = findall(x -> x != 0, map)
println(length(non_zero))

#writedlm("$(@__DIR__)/output.csv",  map, ',')
