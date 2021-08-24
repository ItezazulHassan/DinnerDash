class Order < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy
  validates :user_id, presence: true
  default_scope { order('created_at desc') }
  def sub_total
    sum = 0
    line_items.each do |item|
      sum += item.total_price
    end
    sum
  end
end
