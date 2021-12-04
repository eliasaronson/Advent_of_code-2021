inp = open("$(@__DIR__)/input.txt")

mutable struct Boards
  boards::Matrix{Int32}
  marked::Dict{String, Int32}
end

boards = read(inp, String)
boards = split.(boards, "\n\n")

draw = boards[1]
draw = split.(draw, ",")
draw = parse.(Int32, draw)

boards = split.(boards[2:end], "\n")

play = Boards[]

for b in boards
  filter!(x -> x != "", b)
  board = Array{Int32}(undef, 5, 5)
  for (idx, num) in enumerate(b)
    num = split.(num, " ")
    filter!(x -> x != "", num)
    num = parse.(Int32, num)
    board[idx, :] = num
  end
  push!(play, Boards(board, Dict{String, Int32}()))
end

function run_game(draw, play)
  for (idx, d) in enumerate(draw)
    winners = []
    for idx_b in 1:length(play)
      b = play[idx_b]
      idxs = findall(x->x==d, b.boards)
      if length(idxs) != 0
        i = idxs[1]
        b.marked["r"*"$(i[1])"] = get(b.marked, "r"*"$(i[1])", 0) + 1
        b.marked["c"*"$(i[2])"] = get(b.marked, "c"*"$(i[2])", 0) + 1

        if b.marked["r"*"$(i[1])"] == 5
          if length(play) != 1
            push!(winners, idx_b)
          else
            return b, d, "r"*"$(i[1])", idx
          end
        end
        if b.marked["c"*"$(i[2])"] == 5
          if length(play) != 1
            push!(winners, idx_b)
          else
            return b, d, "c"*"$(i[2])", idx
          end
        end
      end
    end
    deleteat!(play, sort(unique!(winners)))
  end
end

b_win, d_win, pos, idx_win = run_game(draw, copy(play))

println(b_win.boards)
win = filter!(x -> !any(y -> y == x, draw[1:idx_win]), vec(b_win.boards))
res = sum(win)*d_win

println(b_win.boards)
println(idx_win)
println(res)
