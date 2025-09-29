class RenameTypeInTheNews < ActiveRecord::Migration[8.0]
  def change
    rename_column :news, :category, :news_type
  end
end
