class User < ApplicationRecord
    has_secure_password
    has_many :orders, dependent: :destroy
    has_one :cart
    validates :name, presence: true, length: { maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: {minimum: 8}, allow_blank: true
    validates :username, length: {in: 2..32}
    before_save { self.email = email.downcase }
end
