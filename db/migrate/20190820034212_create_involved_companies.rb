class CreateInvolvedCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :involved_companies do |t|
      t.boolean :developer
      t.boolean :publisher
      t.boolean :supporting
      t.boolean :porting
      t.references :game, foreign_key: true
      t.references :company, foreign_key: true

      t.timestamps
    end
  end
end
