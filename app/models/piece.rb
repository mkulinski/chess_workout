class Piece < ActiveRecord::Base
	# shared functionality for all pieces goes here
  belongs_to :game
  # Have the game keep track of which user a piece belongs to, instead of directly associating the pieces with a user.
  belongs_to :player, class_name: "User", foreign_key: :player_id

  def self.join_as_black(game, user)
    self.all.each do |black_piece|
      black_piece.update_attributes(player_id: user.id)
    end
  end
end
