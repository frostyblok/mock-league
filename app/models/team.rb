# frozen_string_literal: true

class Team < ApplicationRecord
  validates_presence_of :name
  has_many :home_fixtures, class_name: 'Fixture', foreign_key: :home_team_id
  has_many :away_fixtures, class_name: 'Fixture', foreign_key: :away_team_id

  def fixtures
    home_fixtures.concat(away_fixtures)
  end
end
