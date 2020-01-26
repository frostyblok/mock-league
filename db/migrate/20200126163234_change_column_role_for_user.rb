class ChangeColumnRoleForUser < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :role, 'user'
  end
end
