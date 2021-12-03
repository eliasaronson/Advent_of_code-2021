using DataStructures

inp = open("$(@__DIR__)/input.txt")
input = readlines(inp)

increase = 0
prev = 9e10
wind = CircularBuffer{Float64}(3)

for i in input[1:2]
  depth = parse(Int32, i)
  push!(wind, depth)
end

for i in input[3:end]
  depth = parse(Int32, i)
  push!(wind, depth)
  sum_d = sum(wind)

  if sum_d > prev
    global increase += 1
  end

  global prev = sum_d
end

println(increase)

