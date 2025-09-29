class RenameTypeInNews < ActiveRecord::Migration[8.0]
  def change
    rename_column :news, :type, :category
  end
end
