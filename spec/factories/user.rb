FactoryBot.define do
  factory :user do
    name                  { 'スペックユーザー' }
    email                 { 'spec@mail' }
    password              { 'password' }
    password_confirmation { 'password' }
  end
end
