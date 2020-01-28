# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  let(:team) { create(:team) }
  let(:my_team) { 'Chelsea' }
  let(:json) { JSON.parse(response.body) }

  def assert_success(message:, status:)
    expect(json['message']).to eq(message)
    expect(json['team_name']).to eq(my_team)
    expect(json['status']).to eq(status)
  end

  context '#index' do
    before { get :index }

    it 'successfully returns all teams' do
      expect(json['message']).to eq('All teams successfully retrieved')
      expect(json['teams']).to eq(Team.all)
    end
  end

  context '#create' do
    before { post :create, params: { name: my_team } }

    it 'successfully creates a new team' do
      assert_success(message: 'Team created successfully', status: 201)
    end
  end

  context '#show' do
    before { get :show, params: { id: team.id } }

    it 'successfully creates a new team' do
      assert_success(message: 'Successfully retrieved team', status: 200)
    end
  end

  context '#update' do
    let(:my_team) { 'Arsenal' }
    before { put :update, params: { id: team.id, name: my_team } }

    it 'successfully creates a new team' do
      assert_success(message: 'Team successfully updated', status: 204)
    end
  end

  context '#destroy' do
    before { post :destroy, params: { id: team.id } }

    it 'successfully creates a new team' do
      assert_success(message: 'Team successfully deleted', status: 204)
      expect(Team.exists?(team.id)).to eq(false)
    end
  end
end
