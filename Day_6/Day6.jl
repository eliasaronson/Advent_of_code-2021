using BenchmarkTools
inp = open("$(@__DIR__)/input.txt")

input = readlines(inp)[1]
input = split.(input, ",")
fish = parse.(Int32, input)

t_end = 80

for i in 1:t_end
  n_new = sum(fish .== 0)
  global fish[fish .== 0] .= 7
  global fish = fish .- 1
  append!(fish, ones(n_new).*8)
end

println(length(fish))

