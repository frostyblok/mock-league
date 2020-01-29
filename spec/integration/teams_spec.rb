# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeamsController, type: :request do
  let(:user) { create(:user, role: 'admin') }
  let!(:team) { create(:team) }
  let(:my_team) { 'Chelsea' }
  let(:json) { JSON.parse(response.body) }
  let(:headers) do
    {
      'Authorization' => generate_token(user.id),
      'Content-Type' => 'application/json'
    }
  end

  def assert_success(message:, status:)
    expect(json['message']).to eq(message)
    expect(json['team_name']).to eq(my_team)
    expect(json['status']).to eq(status)
  end

  context '#index' do
    before { get '/teams', params: {}, headers: headers }

    it 'successfully returns all teams' do
      expect(json['message']).to eq('All teams successfully retrieved')
      expect(json['teams'].size).to eq(Team.all.size)
    end
  end

  context '#create' do
    before { post '/teams', params: { name: my_team }.to_json, headers: headers }

    it 'successfully creates a new team' do
      assert_success(message: 'Team created successfully', status: 201)
    end
  end

  context '#show' do
    before { get "/teams/#{team.id}", params: {}, headers: headers }

    it 'successfully creates a new team' do
      assert_success(message: 'Successfully retrieved team', status: 200)
    end
  end

  context '#update' do
    let(:my_team) { 'Arsenal' }
    before do
      put "/teams/#{team.id}", params: { name: my_team }.to_json, headers: headers
    end

    it 'successfully creates a new team' do
      assert_success(message: 'Team successfully updated', status: 204)
    end
  end

  context '#destroy' do
    before { delete "/teams/#{team.id}", params: {}, headers: headers }

    it 'successfully creates a new team' do
      assert_success(message: 'Team successfully deleted', status: 204)
      expect(Team.exists?(team.id)).to eq(false)
    end
  end

  context 'when a non admin user' do
    let(:user) { create(:user) }

    before { get '/teams', params: {}, headers: headers }

    it 'returns error' do
      expect(json['error']).to eq('You are not authorized to perform action')
    end
  end
end
