class TranslateGameArticles < ActiveRecord::Migration[5.2]
  def change
    reversible do |dir|
      dir.up do
        GameArticle.create_translation_table!({
                                         title: :string, 
                                         summary: :text
                                       }, {
                                         migrate_data: true, 
                                         remove_source_columns: true 
                                       })
      end
      dir.down do
        GameArticle.drop_translation_table! migrate_data: true 
      end
    end
  end
end
