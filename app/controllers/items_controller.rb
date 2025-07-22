class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :show]

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
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

   def show
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(
      :name, :description, :image, :price,
      :category_id, :condition_id, :shipping_fee_id,
      :prefecture_id, :shipping_day_id
    ).merge(user_id: current_user.id)
  end
end
