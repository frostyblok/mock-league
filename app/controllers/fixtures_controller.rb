# frozen_string_literal: true

class FixturesController < ApplicationController
  before_action :fixture, except: %i[index create]

  def index
    fixtures = Fixture.all

    render json: {
      message: 'All fixtures successfully retrieved',
      fixtures: fixtures,
      status: 200
    }
  end

  def create
    new_fixture = Fixture.where(fixture_params).first_or_create!

    render json: {
      message: 'Team created successfully',
      home_team: new_fixture.home_team.name,
      away_team: new_fixture.away_team.name,
      date: new_fixture.date,
      status: 201
    }
  end

  def show
    render json: {
      message: 'Successfully retrieved fixture',
      home_team: @fixture.home_team.name,
      away_team: @fixture.away_team.name,
      date: @fixture.date,
      status: 200
    }
  end

  def update
    @fixture.update!(fixture_params)

    render json: {
      message: 'Fixture successfully updated',
      home_team: @fixture.home_team.name,
      away_team: @fixture.away_team.name,
      date: @fixture.date,
      status: 204
    }
  end

  def destroy
    @fixture.destroy

    render json: { message: 'Team successfully deleted', status: 204 }
  end

  private

  def fixture
    @fixture ||= Fixture.find(params[:id])
  end

  def fixture_params
    params.permit(:home_team_id, :away_team_id, :date)
  end
end
