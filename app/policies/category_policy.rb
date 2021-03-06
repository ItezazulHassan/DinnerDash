# frozen_string_literal: true

# Policy for Category
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

  def edit?
    user.flag?
  end

  def update?
    user.flag?
  end

  # Scope for Category
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
