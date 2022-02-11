class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    #@item = Item.includes(:user).order("created_at DESC")
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end
end

private  # private以下の記述はすべてプライベートメソッドになる

def item_params  # プライベートメソッド
  params.require(:item).permit(:image, :product, :description, :category_id, :situation_id, :delivery_charge_id, :prefecture_id,
                               :shipping_day_id, :price)
        .merge(user_id: current_user.id)
end
