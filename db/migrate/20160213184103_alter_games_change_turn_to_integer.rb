class AlterGamesChangeTurnToInteger < ActiveRecord::Migration
  def change
    change_column :games, :turn, 'integer USING CAST(turn AS integer)'
  end
end
