class TranslateGames < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        Game.create_translation_table!({
                                         storyline: :text, 
                                         summary: :text
                                       }, {
                                         migrate_data: true, 
                                         remove_source_columns: true 
                                       })
      end
      dir.down do
        Game.drop_translation_table! migrate_data: true 
      end
    end
  end
end
