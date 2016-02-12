class ChangeTypesInGames < ActiveRecord::Migration
  def change
  	remove_column :games, :white_player_id
  	add_column :games, :white_player_id, :integer 
  	remove_column :games, :black_player_id
  	add_column :games, :black_player_id, :integer
  end
end
