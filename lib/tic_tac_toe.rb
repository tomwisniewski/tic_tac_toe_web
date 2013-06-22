class TicTacToe

  X = 'X'
  O = '0'

  attr_accessor :board

  def initialize(board)
    raise "The board does not look valid: #{board}" unless board.length == 9
    @board = board.split(//).each_slice(3).to_a
  end

  def valid?
    (no_of_crosses - no_of_noughts).abs < 2
  end

  def no_of_crosses
    @board.flatten.count(X)
  end

  def no_of_noughts
    @board.flatten.count(O)
  end

  def finished?
    line_across? || line_down? || line_diagonal?
  end

  def draw?
    @board.flatten.count(" ") == 0
  end

  def line_diagonal?    
    [[0,4,8], [2,4,6]].any? {|d| winner?(d.map{|index| @board.flatten[index]})}
  end

  def line_down?    
    @board.transpose.any? {|line| winner? line }
  end

  def winner?(line)               
    [[X]*3, [O]*3].include? line
  end

  def line_across?
    @board.any? {|line| winner? line }
  end

  def next_player
    no_of_crosses == no_of_noughts ? X : O
  end

  def current_player
    no_of_crosses > no_of_noughts ? X : O
  end

  def next_move
    (0..8).find {|i| winning_move?(i) }
  end

  def to_s
    @board.flatten.join
  end

  def winning_move?(i)
    clone = self.class.new(to_s)
    clone.move(i)
    clone.finished?
  end

  def move(i)
    @board[i/3][i%3] = next_player
  end

end
