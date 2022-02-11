require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品が出品できる場合' do
      it 'image、product、description、category_id、situation_id、delivery_charge_id、prefecture_id、shipping_day_id、priceが存在すれば出品できる' do
        expect(@item).to be_valid
      end
      it 'priceが300円以上9999999円以下であれば出品できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが300円以上9999999円以下であれば出品できる' do
        @item.price = 9999999
        expect(@item).to be_valid
      end
    end
    context '商品が出品できない場合' do
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include "Image can't be blank"
      end
      it 'productが空では出品できない' do
        @item.product = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Product can't be blank"
      end
      it 'descriptionが空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Description can't be blank"
      end
      it 'category_idが「---」では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end
      it 'situation_idが「---」では出品できない' do
        @item.situation_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Situation can't be blank"
      end
      it 'delivery_charge_idが「---」では出品できない' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery charge can't be blank"
      end
      it 'prefecture_idが「---」では出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'shipping_day_idが「---」では出品できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping day can't be blank"
      end
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end
      it 'priceが全角数字では出品できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price out of setting range'
      end
      it 'priceが300円未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price out of setting range'
      end
      it 'priceが10000000円以上では出品できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price out of setting range'
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end