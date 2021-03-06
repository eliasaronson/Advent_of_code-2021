inp = open("$(@__DIR__)/input.txt")
input = readlines(inp)

depth = 0
hori = 0
aim = 0

for i in input
  command, value = split(i, " ")
  if command == "forward"
    global hori += parse(Int32, value)
    global depth += parse(Int32, value)*aim
  elseif command == "down"
    global aim += parse(Int32, value)
  elseif command == "up"
    global aim -= parse(Int32, value)
  else
    println("Error.")
  end
end

println("Depth: ", depth)
println("Forward: ", hori)
println("Aim: ", aim)

println("Ans: ", depth*hori)
