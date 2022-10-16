class AddModalityToDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    add_reference :delivery_times, :modality, null: false, foreign_key: true
  end
end
