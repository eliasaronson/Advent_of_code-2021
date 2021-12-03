inp = open("$(@__DIR__)/input.txt")
input = readlines(inp)

increase = 0
prev = 9e10

for i in input
  depth = parse(Int32, i)
  if depth > prev
    global increase += 1
  end
  global prev = depth
end

println(increase)

