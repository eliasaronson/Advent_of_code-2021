inp = open("$(@__DIR__)/input.txt")
input = readlines(inp)

input = split.(input, "")

n_sum = zeros(length(input[1]))

for num in input
  num = parse.(Int32, num)
  for (i, n) in enumerate(num)
    n_sum[i] += n
  end
end

N_inp = length(input)

γ = parse(Int32, join(convert.(Int32, n_sum .> (N_inp÷2))), base=2)
ϵ = parse(Int32, join(convert.(Int32, n_sum .< (N_inp÷2))), base=2)

println(γ)
println(ϵ)
println("Ans: ", γ*ϵ)
