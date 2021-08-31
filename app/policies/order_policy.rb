# frozen_string_literal: true

# Policy for Order
class OrderPolicy < ApplicationPolicy
  def update?
    user.flag?
  end

  # Scope for Order
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
