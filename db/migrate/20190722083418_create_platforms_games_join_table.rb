class CreatePlatformsGamesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :games, :platforms do |t|
      t.index :game_id
      t.index :platform_id
    end
  end
end
