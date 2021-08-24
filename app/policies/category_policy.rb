class CategoryPolicy < ApplicationPolicy
  def index?
      user.flag?
  end
  def new?
    user.flag?
  end
  def show?
      user.flag?
  end

  def create?
    user.flag?
  end
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
