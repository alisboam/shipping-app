class AddModalityToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :modality, null: false, foreign_key: true
  end
end
