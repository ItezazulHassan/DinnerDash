class User < ApplicationRecord
    has_many :orders, dependent: :destroy
    has_one :cart
end
