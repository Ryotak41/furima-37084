FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 6) }
    email                 { Faker::Internet.free_email }
    password              { 'abc456' }
    password_confirmation { password }
    last_name             { '名字' }
    name                  { '名前' }
    last_name_kana        { 'ミョウジ' }
    name_kana             { 'ナマエ' }
    birthday              { '2000-12-12' }
  end
end
