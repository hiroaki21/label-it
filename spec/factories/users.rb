FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { "atjf4ti9io" }
    password_confirmation { password }
  end
end