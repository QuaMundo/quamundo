# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  # See https://actionpolicy.evilmartians.io/#/writing_policies
  #

  def index?
    admin?
  end

  def show?
    self_or_admin?
  end

  def new?
    admin?
  end

  def edit?
    self_or_admin?
  end

  def destroy?
    self_or_admin?
  end
  #
  # def update?
  #   # here we can access our context and record
  #   user.admin? || (user.id == record.user_id)
  # end

  # Scoping
  # See https://actionpolicy.evilmartians.io/#/scoping
  #
  # relation_scope do |relation|
  #   next relation if user.admin?
  #   relation.where(user: user)
  # end
end
