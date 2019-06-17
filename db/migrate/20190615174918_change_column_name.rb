class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :games, :platforms, :platform
  end
end
