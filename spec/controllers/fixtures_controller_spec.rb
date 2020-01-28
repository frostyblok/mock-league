require 'rails_helper'

RSpec.describe FixturesController, type: :controller do
  let(:fixture) { create(:fixture) }
  let(:home_team) { create(:team) }
  let(:away_team) { create(:team, name: 'Arsenal') }
  let(:json) { JSON.parse(response.body) }

  def assert_success(message:, home_team:, away_team:, fixture_date:, status:)
    expect(json["message"]).to eq(message)
    expect(json["home_team"]).to eq(home_team.name)
    expect(json["away_team"]).to eq(away_team.name)
    expect(DateTime.parse(json["date"])).to eq(fixture_date)
    expect(json["status"]).to eq(status)
  end

  context "#index" do
    before { get :index }

    it "successfully returns all fixtures" do
      expect(json["message"]).to eq("All fixtures successfully retrieved")
      expect(json["fixtures"]).to eq(Fixture.all)
    end
  end

  context "#create" do
    let(:fixture_date) { Time.parse("Dec 8 2015 10:19") }
    before do
      post :create, params: {
        home_team_id: home_team.id,
        away_team_id: away_team.id,
        date: fixture_date
      }
    end

    it "successfully creates a new fixture" do
      assert_success(
        message: "Team created successfully",
        home_team: home_team,
        away_team: away_team, status: 201,
        fixture_date: fixture_date
      )
    end
  end

  context "#show" do
    before { get :show, params: { id: fixture.id } }

    it "successfully creates a new fixture" do
      assert_success(
        message: 'Successfully retrieved fixture',
        home_team: fixture.home_team,
        away_team: fixture.away_team,
        fixture_date: fixture.date,
        status: 200
      )
    end
  end

  context "#update" do
    let(:away_team) { create(:team, name: 'updata') }
    let(:fixture_date) { Time.parse("Dec 18 2016 10:19") }
    before { put :update, params: { id: fixture.id, home_team_id: home_team.id, away_team_id: away_team.id, date: fixture_date } }

    it "successfully creates a new fixture" do
      assert_success(
        message: 'Fixture successfully updated',
        home_team: home_team,
        away_team: away_team,
        fixture_date: fixture_date,
        status: 204)
    end
  end

  context '#destroy' do
    before { post :destroy, params: { id: fixture.id } }

    it 'successfully creates a new fixture' do
      expect(json["message"]).to eq('Team successfully deleted')
      expect(json["status"]).to eq(204)
      expect(Fixture.exists?(fixture.id)).to eq(false)
    end
  end
end
