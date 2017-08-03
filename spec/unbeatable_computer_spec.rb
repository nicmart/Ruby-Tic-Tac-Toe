require 'spec_helper'
require_relative '../lib/unbeatable_computer'
require_relative '../lib/grid'

RSpec.describe UnbeatableComputer do

  let(:grid) {Grid.new(3)}
  let(:computer) {UnbeatableComputer.new(grid)}

  it "returns duplicated grids each with current player mark placed in different empty cell" do
    grid.place_mark("3", "X")
    grid.place_mark("5", "O")
    grid.place_mark("6", "X")
    possible_move = "X"

    grids_with_moves = computer.grid_copies_with_possible_moves(grid.cells, possible_move)
    first_duplicated_grid = grids_with_moves[0]
    sixth_duplicated_grid = grids_with_moves[5]

    expect(first_duplicated_grid.cells).to eq([possible_move, nil, "X", nil, "O", "X", nil, nil, nil])
    expect(sixth_duplicated_grid.cells).to eq([nil, nil, "X", nil, "O", "X", nil, nil, possible_move])
  end

  describe "returns score for possible move according to game result prediction after minimax application" do
    it "returns 10 if possible move is winning move for computer and it's computer turn" do
      computer_mark = "O"
      grid.place_mark("1", computer_mark)
      grid.place_mark("3", computer_mark)
      possible_moves = computer.grid_copies_with_possible_moves(grid.cells, computer_mark)
      computer_winning_move = possible_moves[0]

      score = computer.score(computer_winning_move, computer_mark)

      expect(score).to eq(10)
    end

    it "returns 10 if opponent doesn't prevent computer from winning in next game states" do
      computer_mark = "O"
      opponent_mark = "X"
      grid.place_mark("1", computer_mark)
      grid.place_mark("3", computer_mark)
      possible_moves = computer.grid_copies_with_possible_moves(grid.cells, opponent_mark)
      opponent_move_different_from_2 = possible_moves[4]

      score = computer.score(opponent_move_different_from_2, computer_mark)

      expect(score).to eq(10)
    end

    it "returns -10 if possible move is winning move for opponent and it's opponent turn" do
      opponent_mark = "X"
      grid.place_mark("1", opponent_mark)
      grid.place_mark("2", opponent_mark)
      possible_moves = computer.grid_copies_with_possible_moves(grid.cells, opponent_mark)
      opponent_winning_move = possible_moves[1]

      score = computer.score(opponent_winning_move, opponent_mark)

      expect(score).to eq(-10)
    end

    it "returns -10 if computer doesn't prevent opponent from winning in next game state" do
      opponent_mark = "X"
      computer_mark = "O"
      grid.place_mark("1", opponent_mark)
      grid.place_mark("2", opponent_mark)
      possible_moves = computer.grid_copies_with_possible_moves(grid.cells, computer_mark)
      computer_move_different_from_3 = possible_moves[2]

      score = computer.score(computer_move_different_from_3, computer_mark)

      expect(score).to eq(-10)
    end

    it "returns 0 if possible move leads to end game which is draw" do
      computer_mark = "O"
      grid.place_mark("3", "O")
      grid.place_mark("2", "X")
      grid.place_mark("5", "O")
      grid.place_mark("1", "X")
      grid.place_mark("4", "O")
      grid.place_mark("7", "X")
      grid.place_mark("8", "O")
      grid.place_mark("6", "X")
      possible_moves = computer.grid_copies_with_possible_moves(grid.cells, computer_mark)
      last_move_possible = possible_moves[0]

      score = computer.score(last_move_possible, computer_mark)

      expect(score).to eq(0)
    end

    it "returns 0 if in next level of game states nobody can win" do
      computer_mark = "O"
      possible_moves = computer.grid_copies_with_possible_moves(grid.cells, computer_mark)
      first_move = possible_moves[0]

      score = computer.score(first_move, computer_mark)

      expect(score).to eq(0)
    end
  end

  it "populates hash with grid copies each with possible move and score" do
    grid.place_mark("3", "O")
    grid.place_mark("2", "X")
    grid.place_mark("5", "O")
    grid.place_mark("1", "X")
    grid.place_mark("4", "O")
    grid.place_mark("7", "X")
    grid.place_mark("8", "O")
    grid.place_mark("6", "X")
    computer_mark = "O"
    possible_scores = [-10, 0, 10]
    computer.add_possible_moves_and_scores

    last_possible_move = computer.possible_moves_and_scores.keys[0].cells.last
    move_score = computer.possible_moves_and_scores.values[0]

    expect(last_possible_move).to eq(computer_mark)
    expect(possible_scores).to include(move_score)
  end

end
