using BenchmarkTools
inp = open("$(@__DIR__)/test_input.txt")

input = readlines(inp)[1]
input = split.(input, ",")
crabs = parse.(Int32, input)

dict = Dict{Int32, Int64}()

for h in minimum(crabs):maximum(crabs)
  dict[h] = sum(abs.(crabs .- h))
end

res = collect(keys(dict))[argmin(collect(values(dict)))]

for key in sort(collect(keys(dict)))
   println("$key => $(dict[key])")
end

println(minimum(values(dict)))
println(res)

