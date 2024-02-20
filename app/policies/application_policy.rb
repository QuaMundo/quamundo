# frozen_string_literal: true

# Base class for application policies
class ApplicationPolicy < ActionPolicy::Base
  # Configure additional authorization contexts here
  # (`user` is added by default).
  #
  #   authorize :account, optional: true
  #
  # Read more about authorization context:
  # https://actionpolicy.evilmartians.io/#/authorization_context

  alias_rule :create?, to: :new?
  alias_rule :update?, to: :edit?

  private

  #  def owner?
  #    record.user_id == user.id
  #  end

  def admin?
    user.admin?
  end

  def self_or_admin?
    (user.id == record.id) || user.admin?
  end
end
