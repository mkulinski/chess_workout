class Game < ActiveRecord::Base
  has_many :pieces
  # The associations below will enable us to use game.white_player, game.black_player:

  belongs_to :white_player, class_name: 'User', foreign_key: :white_player_id
  belongs_to :black_player, class_name: 'User', foreign_key: :black_player_id
  after_create :initialize_board

  # Directly create pieces and add them to the pieces collection.
  def initialize_board
    # Non-pawns for black player:
    Rook.create(x_position: 1, y_position: 1, game_id: id, color: "black", player_id: black_player_id)
    Knight.create(x_position: 2, y_position: 1, game_id: id, color: "black", player_id: black_player_id)
    Bishop.create(x_position: 3, y_position: 1, game_id: id, color: "black", player_id: black_player_id)
    Queen.create(x_position: 4, y_position: 1, game_id: id, color: "black", player_id: black_player_id)
    King.create(x_position: 5, y_position: 1, game_id: id, color: "black", player_id: black_player_id)
    Bishop.create(x_position: 6, y_position: 1, game_id: id, color: "black", player_id: black_player_id)
    Knight.create(x_position: 7, y_position: 1, game_id: id, color: "black", player_id: black_player_id)
    Rook.create(x_position: 8, y_position: 1, game_id: id, color: "black", player_id: black_player_id)

    # Non-pawns for white player:
    Rook.create(x_position: 1, y_position: 8, game_id: id, color: "white", player_id: white_player_id)
    Knight.create(x_position: 2, y_position: 8, game_id: id, color: "white", player_id: white_player_id)
    Bishop.create(x_position: 3, y_position: 8, game_id: id, color: "white", player_id: white_player_id)
    Queen.create(x_position: 4, y_position: 8, game_id: id, color: "white", player_id: white_player_id)
    King.create(x_position: 5, y_position: 8, game_id: id, color: "white", player_id: white_player_id)
    Bishop.create(x_position: 6, y_position: 8, game_id: id, color: "white", player_id: white_player_id)
    Knight.create(x_position: 7, y_position: 8, game_id: id, color: "white", player_id: white_player_id)
    Rook.create(x_position: 8, y_position: 8, game_id: id, color: "white", player_id: white_player_id)

    # Pawns for both players:
    for i in 1..8
      Pawn.create(color: "black", x_position: i, y_position: 2, game_id: id, player_id: black_player_id)
      Pawn.create(color: "white", x_position: i, y_position: 7, game_id: id, player_id: white_player_id)
    end
  end

	def self.join_as_black(game, user)
		game.update_attributes(black_player_id: user.id)
		game.pieces.where(color: "black").join_as_black(game, user)
	end

	def self.next_turn(game)
		next_turn = game.turn + 1
		game.update_attributes(turn: next_turn)
	end

	def self.your_turn?(game, piece)
		case game.turn % 2
		when 1
			return true if piece.color == "white"
		when 0
			return true if piece.color == "black"
		end
		false
	end
end
