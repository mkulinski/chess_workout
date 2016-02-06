class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
    	t.string :white_player_id
    	t.string :black_player_id
    	t.string :turn
    	t.string :winner

      t.timestamps
    end
  end
end
