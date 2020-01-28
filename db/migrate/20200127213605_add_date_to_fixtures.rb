class AddDateToFixtures < ActiveRecord::Migration[6.0]
  def change
    add_column :fixtures, :date, :datetime
  end
end
