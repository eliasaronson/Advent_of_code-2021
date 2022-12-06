using BenchmarkTools, Graphs, GraphPlot, MetaGraphs
inp = open("$(@__DIR__)/input.txt")

input = readlines(inp)

dict = Dict{String, Int64}()
dict_b = Dict{Int64, String}()
n = 0
for nodes in input
  for node in split(nodes, "-")
    if !haskey(dict, node)
      global n += 1
      dict[node] = n
      dict_b[n] = node
    end
  end
end

g = MetaGraph(length(keys(dict)))

n = 0
for edge in input
  e1, e2 = split(edge, "-")
  l1, l2 = dict[e1], dict[e2]
  add_edge!(g, l1, l2)
  set_prop!(g, dict[e1], :name, e1)
  set_prop!(g, dict[e2], :name, e2)
end

paths = dfs_tree(g, 1)
#paths = bfs_tree(g, 1)

labels = []
labels_p = []

for v in vertices(g)
  push!(labels, dict_b[v])
end

gplot(g, nodelabel=labels)

for v in vertices(paths)
  push!(labels_p, dict_b[v])
end

gplot(g, nodelabel=labels)
gplot(paths, nodelabel=labels_p)


function bf_search(g, start, visited)
  n_paths = 0
  for n in neighbors(g, start)
    if props(g, n)[:name] == "end"
      n_paths += 1
    elseif props(g, n)[:name] == "start"
    elseif get(visited, n, 0) > 0 && islowercase(props(g, n)[:name][1])
    else 
      tmp_visisted = copy(visited)
      tmp_visisted[n] = get(tmp_visisted, n, 0) + 1
      n_paths += bf_search(g, n, tmp_visisted)
    end
  end
  return n_paths
end

function start_search(g, start)
  res = 0
  for n in neighbors(g, start)
    visited = Dict{Int64, Int64}()
    visited[n] = get(visited, n, 0) + 1
    res += bf_search(g, n, visited)
  end
  return res
end

n_paths = start_search(g, dict["start"])
println(n_paths)
