FactoryBot.define do
  factory :order_address do
    token                 { 'tok_abcdefghijk00000000000000000' }
    post_code             { '111-1111' }
    prefecture_id         { 2 }
    municipalities        { 'あいう市' }
    address               { '１１１番地' }
    building              { 'あいうビル' }
    telephone             { '09011111111' }
  end
end
