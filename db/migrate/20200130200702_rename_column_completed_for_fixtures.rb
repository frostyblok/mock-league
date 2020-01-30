class RenameColumnCompletedForFixtures < ActiveRecord::Migration[6.0]
  def change
    rename_column :fixtures, :completed, :status
  end
end
