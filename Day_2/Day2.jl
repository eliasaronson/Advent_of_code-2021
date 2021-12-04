using BenchmarkTools, Base.Threads
inp = open("$(@__DIR__)/input.txt")
input = readlines(inp)

function calc(input)
  depth = 0
  hori = 0
  Threads.@threads for i in input
    command, value = split(i, " ")
    if command == "forward"
      hori += parse(Int32, value)
    elseif command == "down"
      depth += parse(Int32, value)
    elseif command == "up"
      depth -= parse(Int32, value)
    else
      println("Error.")
    end
  end
  return depth, hori
end

@btime depth, hori = calc(input)

println("Depth: ", depth)
println("Forward: ", hori)

println("Ans: ", depth*hori)
