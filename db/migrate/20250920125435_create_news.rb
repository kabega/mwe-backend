class CreateNews < ActiveRecord::Migration[8.0]
  def change
    create_table :news do |t|
      t.string :title
      t.string :type
      t.string :photo
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
