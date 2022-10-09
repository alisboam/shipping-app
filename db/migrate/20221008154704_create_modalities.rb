class CreateModalities < ActiveRecord::Migration[7.0]
  def change
    create_table :modalities do |t|
      t.string :name
      t.integer :min_distance
      t.integer :max_distance
      t.integer :min_weight
      t.integer :max_weight
      t.integer :status, default: 0
      t.integer :tax

      t.timestamps
    end
  end
end
