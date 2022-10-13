class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :sender_address
      t.string :sender_name
      t.string :receiver_address
      t.integer :distance_between
      t.string :product_code
      t.integer :weight
      t.integer :width
      t.integer :height
      t.string :receiver_name
      t.string :code
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
