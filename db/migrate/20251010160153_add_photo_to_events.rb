class AddPhotoToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :photo, :string
  end
end
