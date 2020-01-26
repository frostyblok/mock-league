FactoryBot.define do
  factory :user do
    first_name { "first_name" }
    last_name { "last_name" }
    password_digest { 'password' }
    role { "user" }
    email { "#{first_name}.#{last_name}@example.com" }
    favourite_team { "Chelsea" }
  end
end
