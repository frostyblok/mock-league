FactoryBot.define do
  factory :fixture do
    home_team_id { create(:team, name: 'Wizzy').id }
    away_team_id { create(:team, name: 'Khalifa').id }
    date { Time.parse("Dec 8 2015 10:19") }
  end
end
