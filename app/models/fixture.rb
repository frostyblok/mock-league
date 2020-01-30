# frozen_string_literal: true

class Fixture < ApplicationRecord
  validates_presence_of :home_team_id, :away_team_id, :date
  validates_inclusion_of :completed, in: %w[done pending]

  before_save :format_date!
  before_create :set_fixture_link

  belongs_to :home_team, class_name: 'Team', foreign_key: :home_team_id
  belongs_to :away_team, class_name: 'Team', foreign_key: :away_team_id

  scope :completed_fixtures, -> { where(completed: 'done') }
  scope :pending_fixtures, -> { where(completed: 'pending') }

  def teams
    [home_team, away_team]
  end

  private

  def format_date!
    self.date = Time.parse(date.to_s)
  end

  def set_fixture_link
    self.link = "https://watch/#{generate_links}"
  end

  def generate_links
    Array.new(15) { "#{Array('a'..'z').sample}#{rand(1..9)}" }.join
  end
end
