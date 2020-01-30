class SearchController < ApplicationController
  skip_before_action :authorize_request!

  def index
    team = Team.where('lower(name) like lower(?)', "%#{params[:query]}%")

    render json: {
      message: message(context: team, subject: 'teams'),
      team: team.first,
      fixtures: team.first&.fixtures,
      status: 200
    }
  end
end
