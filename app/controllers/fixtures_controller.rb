# frozen_string_literal: true

class FixturesController < ApplicationController
  before_action :authorize_admin,
                except: %i[completed_fixtures pending_fixtures]
  before_action :fixture,
                except: %i[index create completed_fixtures pending_fixtures]

  def index
    fixtures = Fixture.all

    render json: {
      message: message(context: fixtures, subject: 'fixtures'),
      fixtures: fixtures,
      status: 200
    }
  end

  def completed_fixtures
    completed_fixtures = Fixture.completed_fixtures

    result_response(subject: 'completed fixtures', result: completed_fixtures)
  end

  def pending_fixtures
    pending_fixtures = Fixture.pending_fixtures

    result_response(subject: 'pending fixtures', result: pending_fixtures)
  end

  def create
    new_fixture = Fixture.where(fixture_params).first_or_create!

    render json: {
      message: 'Fixture created successfully',
      home_team: new_fixture.home_team.name,
      away_team: new_fixture.away_team.name,
      date: new_fixture.date,
      status: 201
    }
  end

  def show
    render json: {
      message: 'Successfully retrieved fixture',
      home_team: fixture.home_team.name,
      away_team: fixture.away_team.name,
      date: fixture.date,
      status: 200
    }
  end

  def update
    @fixture.update!(fixture_params)

    render json: {
      message: 'Fixture successfully updated',
      home_team: fixture.home_team.name,
      away_team: fixture.away_team.name,
      date: fixture.date,
      status: 204
    }
  end

  def update_scores
    fixture.update!(fixture_scores_params)

    render json: {
      message: 'Scores successfully updated',
      home_team_score: fixture.home_team_score,
      away_team_score: fixture.away_team_score,
      completed: fixture.completed,
      status: 202
    }
  end

  def destroy
    fixture.destroy

    render json: { message: 'Team successfully deleted', status: 204 }
  end

  private

  def fixture
    @fixture ||= Fixture.find(params[:id])
  end

  def fixture_params
    params.permit(:home_team_id, :away_team_id, :date)
  end

  def fixture_scores_params
    params.permit(:home_team_score, :away_team_score, :completed)
  end

  def result_response(result:, subject:)
    render json: {
      message: message(context: result,
                       subject: subject),
      fixtures: result,
      status: 200
    }
  end
end
