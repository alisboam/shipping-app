class CreatePricesByDistances < ActiveRecord::Migration[7.0]
  def change
    create_table :prices_by_distances do |t|
      t.integer :min_distance
      t.integer :max_distance
      t.integer :price

      t.timestamps
    end
  end
end
