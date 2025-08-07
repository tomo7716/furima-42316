class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }
    validates :city
    validates :house_number
    validates :token
    validates :user_id
    validates :item_id
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }# 都道府県でid:1は「--」などの無効値


  def save
    order = Order.create!(user_id: user_id, item_id: item_id)
    Address.create!(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      house_number: house_number,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
    order
  end
end
