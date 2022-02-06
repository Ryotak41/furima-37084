class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :situation
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :shipping_day

  validates  :product, presence: true
  validates  :description, presence: true
  validates  :category_id, numericality: { other_than: 1, message: "can't be blank" }
  validates  :situation_id, numericality: { other_than: 1, message: "can't be blank" }
  validates  :delivery_charge_id, numericality: { other_than: 1, message: "can't be blank" }
  validates  :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
  validates  :shipping_day_id, numericality: { other_than: 1, message: "can't be blank" }
  validates  :price, presence: true, format: { with: /\A[0-9]+\z/, message: 'half-width number' }
  validates  :price,
             numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                             message: 'out of setting range' }
  validates  :image, presence: true

  belongs_to :user
  # has_one   :order
  has_one_attached :image
end
