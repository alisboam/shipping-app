class RemoveCollumnFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :access
  end
end
