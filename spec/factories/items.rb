FactoryBot.define do
  factory :item do
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
    product               { '商品名' }
    description           { '商品の説明' }
    category_id           { '2' }
    situation_id          { '2' }
    delivery_charge_id    { '2' }
    prefecture_id         { '2' }
    shipping_day_id       { '2' }
    price                 { '1000' }
    association :user
  end
end
