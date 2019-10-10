# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.integer :external_id
      t.string :name
      t.string :description
      t.string :logo
      t.integer :start_date
      t.integer :start_date_category
      t.string :url

      t.timestamps
    end
  end
end
