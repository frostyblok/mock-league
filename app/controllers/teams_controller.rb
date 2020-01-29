# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :authorize_admin
  before_action :team, except: %i[index create]

  def index
    teams = Team.all

    render json: { message: message(context: teams, subject: 'teams'),
                   teams: teams, status: 200 }
  end

  def create
    new_team = Team.create!(team_params)

    render json: {
      message: 'Team created successfully',
      team_name: new_team.name,
      status: 201
    }
  end

  def show
    render json: { message: 'Successfully retrieved team',
                   team_name: @team.name, status: 200 }
  end

  def update
    @team.update!(team_params)

    render json: { message: 'Team successfully updated',
                   team_name: @team.name, status: 204 }
  end

  def destroy
    @team.destroy

    render json: { message: 'Team successfully deleted',
                   team_name: @team.name, status: 204 }
  end

  private

  def team
    @team ||= Team.find(params[:id])
  end

  def team_params
    params.permit(:name)
  end
end
