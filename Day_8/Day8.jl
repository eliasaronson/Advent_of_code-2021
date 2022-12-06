using BenchmarkTools
inp = open("$(@__DIR__)/input.txt")

input = readlines(inp)

n_unique = 0

for l in input
  note, out = split(l, " | ")
  out = split(out, " ")
  n = length.(out)
  global n_unique += sum((n .== 2) .| (n .== 4) .| (n .== 3) .| (n .== 7))
end

println(n_unique)
