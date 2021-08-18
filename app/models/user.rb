class User < ApplicationRecord
    has_many :orders, dependent: :destroy
    has_one :cart
    validates :name, presence: true, length: { maximum: 50}
    validates :email, presence: true, uniqueness: {case_sensitive: false}, email: true, format: /@/, length: {maximum: 255}
    validates :password, presence: true, length: {minimum: 8}
    validates :username, length: {in: 2..32}
end
