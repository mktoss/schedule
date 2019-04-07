FactoryBot.define do
  factory :project do
    name { 'スペックプロジェクト' }
    association :owner, factory: :user
  end
end
