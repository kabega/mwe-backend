class CreateJobListings < ActiveRecord::Migration[8.0]
  def change
    create_table :job_listings do |t|
      t.string :title
      t.text :description
      t.string :location
      t.string :status
      t.string :qualifications
      t.string :experience
      t.integer :salary
      t.string :salary_currency
      t.datetime :deadline
      t.references :user, null: false, foreign_key: true
      t.string :job_type

      t.timestamps
    end
  end
end
