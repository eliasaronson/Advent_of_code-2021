using BenchmarkTools
inp = open("$(@__DIR__)/input.txt")

input = readlines(inp)

function decorde(input)
  res = 0
  dict = Dict{String, Int32}()
  for l in input
    out, dec = split(l, " | ")
    out = split(out, " ")
    n = length.(out)
    dict[join(sort(collect(out[n .== 2][1])))] = 1
    dict[join(sort(collect(out[n .== 4][1])))] = 4
    dict[join(sort(collect(out[n .== 3][1])))] = 7
    dict[join(sort(collect(out[n .== 7][1])))] = 8
    for d in out[n .== 6]
      if length(intersect(collect(d), collect(out[n .== 2][1]))) == 1
        dict[join(sort(collect(d)))] = 6
      elseif length(intersect(collect(d), collect(out[n .== 4][1]))) == 4
        dict[join(sort(collect(d)))] = 9
      else
        dict[join(sort(collect(d)))] = 0
      end
    end
    two_tmp = ""
    for d in out[n .== 5]
      if length(intersect(collect(d), collect(out[n .== 4][1]))) == 2
        two_tmp = join(sort(collect(d)))
        dict[two_tmp] = 2
      end
    end
    for d in out[n .== 5]
      if join(sort(collect(d))) != two_tmp
        if length(intersect(collect(d), collect(out[n .== 3][1]))) == 3
          dict[join(sort(collect(d)))] = 3
        else
          dict[join(sort(collect(d)))] = 5
        end
      end
    end
    dec = split(dec, " ")
    res_l = 0
    for (idx, d) in enumerate(dec)
      println(d)
      v = dict[join(sort(collect(d)))] * 10^(4-idx)
      res_l += v
      println(v)
    end
    res += res_l
    println(res_l)
  end
  return res, dict
end

res, dictr = decorde(input)
println(res)
