class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string     :product
      t.text       :description
      t.integer    :category_id
      t.integer    :situation_id
      t.integer    :delivery_charge_id
      t.integer    :prefecture_id
      t.integer    :shipping_day_id
      t.integer    :price
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
