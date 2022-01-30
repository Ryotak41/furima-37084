require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'name、email、password、password_confirmation、last_name、name、last_name_kana、name_kana、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが英数字混合、6文字以上であれば登録できる' do
        @user.password = 'a23456'
        @user.password_confirmation = 'a23456'
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'emailに＠が含まれていなければ登録できない' do
        @user.email = 'xxxxxxgmail.co.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include 'Email is invalid'
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'a2345'
        @user.password_confirmation = 'a2345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'a23456'
        @user.password_confirmation = 'a234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordが英語のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordに全角文字が含まれると登録できない' do
        @user.password = 'a23456７'
        @user.password_confirmation = 'a23456７'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it '名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '名字が全角英語では登録できない' do
        @user.last_name = 'ａｂｃ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名字が全角数字では登録できない' do
        @user.last_name = '１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名前が空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name can't be blank")
      end
      it '名前が全角英語では登録できない' do
        @user.name = 'ａｂｃ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name is invalid')
      end
      it '名前が全角数字では登録できない' do
        @user.name = '１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name is invalid')
      end
      it '名字カナが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it '名字カナが全角英語では登録できない' do
        @user.last_name_kana = 'ａｂｃ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名字カナが全角数字では登録できない' do
        @user.last_name_kana = '１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名字カナが漢字では登録できない' do
        @user.last_name_kana = '名字'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名字カナがひらがなでは登録できない' do
        @user.last_name_kana = 'みょうじ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名前カナが空では登録できない' do
        @user.name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Name kana can't be blank")
      end
      it '名前カナが全角英語では登録できない' do
        @user.name_kana = 'ａｂｃ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana is invalid')
      end
      it '名前カナが全角数字では登録できない' do
        @user.name_kana = '１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana is invalid')
      end
      it '名前カナが漢字では登録できない' do
        @user.name_kana = '名前'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana is invalid')
      end
      it '名前カナがひらがなでは登録できない' do
        @user.name_kana = 'なまえ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Name kana is invalid')
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
