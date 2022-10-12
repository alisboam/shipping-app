class AddModalityToPrice < ActiveRecord::Migration[7.0]
  def change
    add_reference :prices_by_distances, :modality, null: false, foreign_key: true
    add_reference :prices_by_weights, :modality, null: false, foreign_key: true
  end
end
