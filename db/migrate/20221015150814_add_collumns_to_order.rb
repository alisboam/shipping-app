class AddCollumnsToOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :modality, null: true, foreign_key: true
    add_column :orders, :delivery_price, :integer, null: true
    add_column :orders, :estimated_delivery_date, :datetime, null: true
    add_reference :orders, :vehicle, null: true, foreign_key: true
    add_column :orders, :delivery_date, :datetime, null: true
    add_column :orders, :delay_reason, :string, null: true
  end
end
