class AddLinkToFixtures < ActiveRecord::Migration[6.0]
  def change
    add_column :fixtures, :link, :string
  end
end
