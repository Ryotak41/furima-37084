class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :current_user_check, only: [:index, :create]
  before_action :sold_out_check, only: [:index, :create]

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :municipalities, :address, :building, :telephone).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]   # PAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount:   @item.price,      # 商品の値段
      card:     params[:token],   # カードトークン
      currency: 'jpy'             # 通貨の種類（日本円）
    )
  end

  def current_user_check
    redirect_to root_path if @item.user_id == current_user.id
  end

  def sold_out_check
    redirect_to root_path if @item.order != nil
  end

end
