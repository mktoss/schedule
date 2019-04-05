FactoryBot.define do
  factory :user do
    name                  { 'スペックユーザー' }
    email                 { 'spec@mail' }
    password              { 'password' }
    password_confirmation { 'password' }

    after(:create) do |user|
      create(:project_user, user: user, project: create(:project))
    end
  end
end
