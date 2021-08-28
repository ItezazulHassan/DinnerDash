# frozen_string_literal: true

class ItemCategoryPolicy < ApplicationPolicy
  def new?
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
