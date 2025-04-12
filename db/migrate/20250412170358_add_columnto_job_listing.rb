class AddColumntoJobListing < ActiveRecord::Migration[8.0]
  def change
    add_column :job_listings , :application_counter , :integer, default: 0
  end
end
