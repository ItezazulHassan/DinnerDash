class ItemPolicy < ApplicationPolicy
  # attr_reader :user, :item
  # def initialize(user, item)
  #   @user = user
  #   @item = item
  # end

  def new?
    user.flag?
  end

  def update?
    user.flag?
  end

  def create?
    user.flag?
  end

  def edit?
    user.flag?
  end

  def destroy?
    user.flag?
  end

  class Scope < Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.flag?
        scope.all
      else
        scope.where(flag: true)
      end
    end

    private

    attr_reader :user, :scope
  end
end
