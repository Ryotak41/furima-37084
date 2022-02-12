class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :current_user_check]
  before_action :current_user_check, only:[:edit, :update]

  def index
    @items = Item.order('created_at DESC')
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

  def show
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end
  
end

private  # private以下の記述はすべてプライベートメソッドになる

def set_item
  @item = Item.find(params[:id])
end

def item_params  # プライベートメソッド
  params.require(:item).permit(:image, :product, :description, :category_id, :situation_id, :delivery_charge_id, :prefecture_id,
                               :shipping_day_id, :price)
        .merge(user_id: current_user.id)
end

def current_user_check
  if @item.user_id != current_user.id
    redirect_to action: :index
  end
end