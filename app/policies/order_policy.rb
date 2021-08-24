class OrderPolicy < ApplicationPolicy
  def update?
    user.flag?
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
