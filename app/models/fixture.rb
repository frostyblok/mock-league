class Fixture < ApplicationRecord
  validates_presence_of :home_team_id, :away_team_id
  belongs_to :home_team, class_name: "Team", foreign_key: :home_team_id
  belongs_to :away_team, class_name: "Team", foreign_key: :away_team_id
end
