require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @item.image = fixture_file_upload('public/images/test_image.png')
    @order = Order.create(user_id: @user.id, item_id: @item.id)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id, order_id: @order.id)
    sleep 0.1
  end

  describe '商品購入機能' do
    context '商品を購入できる場合' do
      it 'post_code、prefecture_id、municipalities、address、telephome、tokenが存在すれば購入できる' do
        expect(@order_address).to be_valid
      end
      it 'post_codeは３桁ハイフン４桁の半角文字列の場合、購入できる' do
        @order_address.post_code = '123-1234'
        expect(@order_address).to be_valid
      end
      it 'buildingは空でも購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end
    context '商品を購入できない場合' do
      it 'post_codeが空では購入できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Post code can't be blank", "Post code is invalid. Include hyphen(-)"
      end
      it 'post_codeに３桁ハイフン４桁の半角文字列以外は購入できない' do
        @order_address.post_code = '1231234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Post code is invalid. Include hyphen(-)"
      end
      it 'post_codeが全角文字列の場合は購入できない' do
        @order_address.post_code = '１２３ー１２３４'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Post code is invalid. Include hyphen(-)"
      end
      it 'prefecture_idが「---」では購入できない' do
        @order_address.prefecture_id = 1
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Prefecture can't be blank"
      end
      it 'municipalitiesが空では購入できない' do
        @order_address.municipalities = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Municipalities can't be blank"
      end
      it 'addressが空では購入できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Address can't be blank"
      end
      it 'telephoneが空では購入できない' do
        @order_address.telephone = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Telephone can't be blank", "Telephone is invalid"
      end
      it 'telephoneが９桁以下では購入できない' do
        @order_address.telephone = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Telephone is invalid"
      end
      it 'telephoneが１２桁以上では購入できない' do
        @order_address.telephone = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Telephone is invalid"
      end
      it 'telephoneに半角数字以外の文字列が含まれていた場合は購入できない' do
        @order_address.telephone = '090-111-111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Telephone is invalid"
      end
      it 'telephoneが全角数字では購入できない' do
        @order_address.telephone = '１２３４５６７８９０'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include "Telephone is invalid"
      end
      it "tokenが空では購入できない" do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
