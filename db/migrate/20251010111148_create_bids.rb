class CreateBids < ActiveRecord::Migration[8.0]
  def change
    create_table :bids do |t|
      t.string :title
      t.string :type

      t.timestamps
    end
  end
end
