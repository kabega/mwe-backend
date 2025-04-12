class SetDefaultStatusForJobListings < ActiveRecord::Migration[8.0]
  def change
    change_column_default :job_listings, :status, from: nil, to: "Open"
  end
end
