require 'rails_helper'

RSpec.describe SearchController, type: :request do
  let(:user) { create(:user) }
  let!(:home_team) { create(:team, name: 'Chelsea') }
  let(:first_away_team) { create(:team, name: 'Arsenal') }
  let(:second_away_team) { create(:team, name: 'Tottenham') }
  let!(:first_fixture) { create(:fixture, home_team_id: home_team.id, away_team_id: first_away_team.id) }
  let!(:second_fixture) { create(:fixture, home_team_id: home_team.id, away_team_id: second_away_team.id) }
  let(:json) { JSON.parse(response.body) }
  let(:headers) do
    {
      'Authorization' => generate_token(user.id),
      'Content-Type' => 'application/json'
    }
  end

  context 'search team name' do
    before { get '/search', params: { query: 'Chelsea' } }

    it 'returns team' do
      expect(json['team']['name']).to eq(home_team.name)
    end

    it 'returns both home and away fixtures' do
      expect(json['fixtures'].count).to eq(home_team.fixtures.count)
    end
  end
end
