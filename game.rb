require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/tic_tac_toe'

class TicTacToeWeb < Sinatra::Base
    
  helpers do 
    def decide_game
      if @game.finished?
        @winner = @game.current_player
        @msg = "Congratulations #{@winner} - you won!"
        erb :home
      elsif @game.draw?
        @msg = "Game drawn!"
        erb :home
      else  
        @msg = @game.current_player == "X" ? "Next move 0" : "Next move X"
        erb :home
      end 
    end  
  end 

  get '/' do
    @game = TicTacToe.new('         ')
    @msg = "X must be placed first!"
    erb :home
  end 

  post '/' do
    @game_in_progess = params[:cells].join
    @game = TicTacToe.new(@game_in_progess) 
    decide_game
  end  

end  

