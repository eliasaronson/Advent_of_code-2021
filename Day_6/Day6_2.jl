using BenchmarkTools, DataStructures
inp = open("$(@__DIR__)/input.txt")

input = readlines(inp)[1]
input = split.(input, ",")
fish = parse.(Int16, input)

fish_d = CircularBuffer{Int64}(9)

for i in 0:8
  push!(fish_d, sum(fish .== i))
end

println(fish_d)

t_end = 256

for i in 1:t_end
  fish_d[8] += fish_d[1]
  push!(fish_d, fish_d[1])
end

println(sum(fish_d))

