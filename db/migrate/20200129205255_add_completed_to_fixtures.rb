class AddCompletedToFixtures < ActiveRecord::Migration[6.0]
  def change
    add_column :fixtures, :completed, :string, default: 'pending'
  end
end
