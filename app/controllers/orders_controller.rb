class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :redirect_if_sold

  def new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :new
    end
  end

  private

  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :house_number,
      :building_name, :phone_number, :token
    ).merge(
      user_id: current_user.id,
      item_id: params[:item_id],
      token: params[:order_address][:token]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def redirect_if_sold
    redirect_to root_path if @item.order.present?
  end
end
