class ChangeTypesInPieces < ActiveRecord::Migration
  def change
  	remove_column :pieces, :x_position
  	remove_column :pieces, :y_position
  	remove_column :pieces, :player_id
  	remove_column :pieces, :game_id
  	add_column :pieces, :x_position, :integer
  	add_column :pieces, :y_position, :integer
  	add_column :pieces, :player_id, :integer
  	add_column :pieces, :game_id, :integer
  end
end
