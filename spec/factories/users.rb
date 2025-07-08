FactoryBot.define do
  factory :user do
    nickname { Faker::Internet.username }
    email { Faker::Internet.email }

    password do
      base_password = Faker::Internet.password(min_length: 4)
      "#{base_password}1a"
    end
    password_confirmation { password }
    last_name { '振間' }
    first_name { '太郎' }
    last_name_kana { 'フリマ' }
    first_name_kana { 'タロウ' }
    birth_date { Date.new(2000, 1, 1) }
  end
end
