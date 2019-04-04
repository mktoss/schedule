FactoryBot.define do
  factory :event do
    title     { 'テストタイトル' }
    all_day   { 'false' }
    start     { '2019-04-01 12:00:00' }
    end_time  { '2019-04-01 13:00:00' }
    address   { '東京都' }
    bar_color { '#ff7f7f' }
    memo      { 'テストメモ' }
    todo      { 'false' }
    user
    project
  end
end
