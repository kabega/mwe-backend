class AddUmbrellaRefToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :umbrella, null: false, foreign_key: true
  end
end
