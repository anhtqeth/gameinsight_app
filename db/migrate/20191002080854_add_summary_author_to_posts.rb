# frozen_string_literal: true

class AddSummaryAuthorToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :summary, :text
    add_column :posts, :author, :string
  end
end
