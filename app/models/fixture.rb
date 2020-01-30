# frozen_string_literal: true

class Fixture < ApplicationRecord
  validates_presence_of :home_team_id, :away_team_id, :date
  validates_inclusion_of :completed, in: %w[done pending]

  belongs_to :home_team, class_name: 'Team', foreign_key: :home_team_id
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_team_id

  scope :completed_fixtures, -> { where(completed: 'done') }
  scope :pending_fixtures, -> { where(completed: 'pending') }
end
