# frozen_string_literal: true

class AddSlugToPlatforms < ActiveRecord::Migration[5.2]
  def change
    add_column :platforms, :slug, :string
    add_index :platforms, :slug, unique: true
  end
end
