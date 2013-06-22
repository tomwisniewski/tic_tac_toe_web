require 'minitest/autorun'
require_relative '../lib/tic_tac_toe'

class TicTacToeTest < Minitest::Test

  # the board is represented as a string of rows, e.g.
  # X |   | X
  # ---------
  # 0 | 0 | X
  # ---------
  #   |   | 0
  #
  # is represented as "X X00X  0"
  #
  # A blank board is represented as an array with 9 spaces
  #
  # The board is valid is the difference between the number of Xs and 0s is 1 or less
  #
  # The first move is always a cross, so if, for example, a board is initialised with two crosses
  # and two noughts, you know the next move is a cross.

  def test_a_board_with_fewer_or_more_than_9_values_cannot_be_created
    assert_raises(RuntimeError) do
      TicTacToe.new("")   
    end
  end

  def test_a_board_with_two_Xs_and_one_0_is_valid?
    game = TicTacToe.new("X X   0  ")
    assert game.valid?
  end

  def test_a_board_with_three_0_and_one_X_is_invalid?
    game = TicTacToe.new(" 0 0 0X  ")
    refute game.valid?
  end

  def test_the_board_with_nine_blank_spaces_is_valid
    game = TicTacToe.new('         ')
    assert game.valid?
  end

  def test_the_game_with_a_horizontal_line_is_finished
    game = TicTacToe.new("XXX 0 0  ")
    assert game.valid?
    assert game.finished?
  end

  def test_has_a_winning_diagonal
    game = TicTacToe.new("0XXX0X000")
    assert game.line_diagonal?
  end

  def test_has_no_winning_diagonal
    game = TicTacToe.new("0XXX0X00X")
    refute game.line_diagonal?
  end

  def test_has_a_winning_line_across
    game = TicTacToe.new("XXX00    ")
    assert game.line_across?
  end

  def test_has_no_winning_line_across
    game = TicTacToe.new("X0X00    ")
    refute game.line_across?
  end

  def test_has_a_winning_line_down
    game = TicTacToe.new("XX0X0 X 0")
    assert game.line_down?
  end

  def test_has_no_winning_line_down
    game = TicTacToe.new("X0X 0  X ")
    refute game.line_down?
  end

  def test_the_game_with_a_vertical_line_is_finished
    game = TicTacToe.new('X 0X00X  ')
    assert game.valid?
    assert game.finished?
  end

  def test_the_game_with_a_diagonal_line_is_finished
    game = TicTacToe.new("X  0X0  X")
    assert game.valid?
    assert game.finished?
  end

  def test_the_game_with_a_diagonal_line_is_finished
    game = TicTacToe.new("XX0 0 0XX")
    assert game.valid?
    assert game.finished?
  end

  def test_the_game_without_a_winner_is_not_finished
    game = TicTacToe.new("XX00XXX00")
    assert game.valid?
    assert !game.finished?
  end

  def test_knows_if_a_line_is_a_winner
    game = TicTacToe.new(" " * 9)
    assert game.winner?([TicTacToe::X] * 3)
    refute game.winner?([TicTacToe::X, TicTacToe::X, TicTacToe::O])
  end

  def test_to_s
    game = TicTacToe.new("XX00XXX00")
    assert_equal "XX00XXX00", game.to_s
  end

  def test_no_of_crosses
    game = TicTacToe.new("XX00XXX00")
    assert 5, game.no_of_crosses
  end

  def test_no_of_noughts
    game = TicTacToe.new("XX00XXX00")
    assert 4, game.no_of_noughts
  end

  def test_the_game_that_is_one_step_from_winning_can_calculate_the_best_move
    game = TicTacToe.new("X 0X0    ")    
    assert_equal 6, game.next_move              # 6 is the index in the grid, 0 to 8
  end

  def test_knows_if_a_certain_move_is_a_winning_one
    game = TicTacToe.new("X 0X0    ")
    assert game.winning_move?(6)
    refute game.winning_move?(8)
  end

  def test_making_a_move
    game = TicTacToe.new("X 0X0    ")
    game.move 6
    assert_equal "X 0X0 X  ", game.to_s
  end

  def test_the_game_knows_the_next_player
    game = TicTacToe.new("X 0X0    ")
    assert_equal TicTacToe::X, game.next_player # X is the first because we assume X started the game    
  end

end