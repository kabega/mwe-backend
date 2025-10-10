class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :title
      t.string :event_type
      t.text :description
      t.string :venue
      t.string :organizer
      t.string :status
      t.text :event_material
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
