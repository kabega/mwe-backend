class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :department
      t.text :description
      t.text :objective
      t.string :project_manager
      t.string :location
      t.date :start_date
      t.date :end_date
      t.string :status
      t.string :priority
      t.decimal :budget, precision: 15, scale: 2

      t.timestamps
    end
  end
end
