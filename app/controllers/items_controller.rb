class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :current_user_check, :destroy]
  before_action :current_user_check, only: [:edit, :update, :destroy]

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

  def destroy
    @item.destroy
    redirect_to root_path
  end
end

private

def set_item
  @item = Item.find(params[:id])
end

def item_params
  params.require(:item).permit(:image, :product, :description, :category_id, :situation_id, :delivery_charge_id, :prefecture_id,
                               :shipping_day_id, :price)
        .merge(user_id: current_user.id)
end

def current_user_check
  redirect_to action: :index if @item.user_id != current_user.id
end
