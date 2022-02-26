class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipalities, :address, :building, :telephone, :item_id, :user_id, :order_id, :token

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :municipalities
    validates :address
    validates :telephone, format: {with: /\A[0-9]{10,11}\z/, message: "is invalid"}
    validates :item_id
    validates :user_id
    validates :token
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address, building: building, telephone: telephone, order_id: order.id)
  end
end