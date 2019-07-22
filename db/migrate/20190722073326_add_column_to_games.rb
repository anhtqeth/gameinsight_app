class AddColumnToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :popularity, :decimal
  end
end
