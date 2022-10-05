class RenameUserRoleColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :access, :role
  end
end
