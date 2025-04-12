class AddEmployerOnJoblisting < ActiveRecord::Migration[8.0]
  def change
    add_column :job_listings, :employer, :string
  end
end
