class RenameTypeInBids < ActiveRecord::Migration[8.0]
  def change
    rename_column :bids, :type, :bid_type
  end
end
