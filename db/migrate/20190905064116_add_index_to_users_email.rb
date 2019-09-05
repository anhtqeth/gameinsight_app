class AddIndexToUsersEmail < ActiveRecord::Migration[5.2]
  def change
              #Model  #Column #Uniqueness
    add_index :users, :email, unique: true
  end
end
