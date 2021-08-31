# frozen_string_literal: true

# Policy for Item Category
class ItemCategoryPolicy < ApplicationPolicy
  def new?
    user.flag?
  end

  def create?
    user.flag?
  end

  # Scope for Item Category
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
