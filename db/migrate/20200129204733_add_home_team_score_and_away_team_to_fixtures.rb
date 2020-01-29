class AddHomeTeamScoreAndAwayTeamToFixtures < ActiveRecord::Migration[6.0]
  def change
    add_column :fixtures, :home_team_score, :integer
    add_column :fixtures, :away_team_score, :integer
  end
end
