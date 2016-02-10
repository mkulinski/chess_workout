class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @game_new = Game.new
    @games = Game.all
    @user = User.all
  end

  def show
    # .find_by_id will return a nil value if the id doesn't exist.
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank?
    @white_king = King.where(:game_id => @game.id.to_s, :color => "white")[0]
    @white_queen = Queen.where(:game_id => @game.id.to_s, :color => "white")[0]
    @white_bishop1 = Bishop.where(:game_id => @game.id.to_s, :color => "white")[0]
    @white_bishop2 = Bishop.where(:game_id => @game.id.to_s, :color => "white")[1]
    @white_knight1 = Knight.where(:game_id => @game.id.to_s, :color => "white")[0]
    @white_knight2 = Knight.where(:game_id => @game.id.to_s, :color => "white")[1]
    @white_rook1 = Rook.where(:game_id => @game.id.to_s, :color => "white")[0]
    @white_rook2 = Rook.where(:game_id => @game.id.to_s, :color => "white")[1]
    @white_pawn1 = Pawn.where(:game_id => @game.id.to_s, :color => "white")[0]
    @white_pawn2 = Pawn.where(:game_id => @game.id.to_s, :color => "white")[1]
    @white_pawn3 = Pawn.where(:game_id => @game.id.to_s, :color => "white")[2]
    @white_pawn4 = Pawn.where(:game_id => @game.id.to_s, :color => "white")[3]
    @white_pawn5 = Pawn.where(:game_id => @game.id.to_s, :color => "white")[4]
    @white_pawn6 = Pawn.where(:game_id => @game.id.to_s, :color => "white")[5]
    @white_pawn7 = Pawn.where(:game_id => @game.id.to_s, :color => "white")[6]
    @white_pawn8 = Pawn.where(:game_id => @game.id.to_s, :color => "white")[7]

    @black_king = King.where(:game_id => @game.id.to_s, :color => "black")[0]
    @black_queen = Queen.where(:game_id => @game.id.to_s, :color => "black")[0]
    @black_bishop1 = Bishop.where(:game_id => @game.id.to_s, :color => "black")[0]
    @black_bishop2 = Bishop.where(:game_id => @game.id.to_s, :color => "black")[1]
    @black_knight1 = Knight.where(:game_id => @game.id.to_s, :color => "black")[0]
    @black_knight2 = Knight.where(:game_id => @game.id.to_s, :color => "black")[1]
    @black_rook1 = Rook.where(:game_id => @game.id.to_s, :color => "black")[0]
    @black_rook2 = Rook.where(:game_id => @game.id.to_s, :color => "black")[1]
    @black_pawn1 = Pawn.where(:game_id => @game.id.to_s, :color => "black")[0]
    @black_pawn2 = Pawn.where(:game_id => @game.id.to_s, :color => "black")[1]
    @black_pawn3 = Pawn.where(:game_id => @game.id.to_s, :color => "black")[2]
    @black_pawn4 = Pawn.where(:game_id => @game.id.to_s, :color => "black")[3]
    @black_pawn5 = Pawn.where(:game_id => @game.id.to_s, :color => "black")[4]
    @black_pawn6 = Pawn.where(:game_id => @game.id.to_s, :color => "black")[5]
    @black_pawn7 = Pawn.where(:game_id => @game.id.to_s, :color => "black")[6]
    @black_pawn8 = Pawn.where(:game_id => @game.id.to_s, :color => "black")[7]
  end

  def create
    @game = Game.create_game(game_params)
    if @game.valid?
      redirect_to game_path(@game)
    else
      render_not_found(:unprocessable_entity)
    end
  end


  private
  def game_params
    params.require(:game).permit(:white_player_id, :black_player_id, :turn, :winner)
  end

  def render_not_found(status=:not_found)
    render :text => "#{status.to_s.titleize}", :status => status
  end
end
