# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  # See https://actionpolicy.evilmartians.io/#/testing?id=rspec-dsl

  let(:user) { build_stubbed(:user) }
  let(:context) { { user: } }
  let(:record) { user }

  describe_rule :index? do
    failed 'for regular user' do
      include_context 'with session'
    end

    succeed 'for admin user' do
      include_context 'with admin session'
    end
  end

  describe_rule :show? do
    succeed 'for regular user for own account' do
      include_context 'with session'
    end

    failed 'for regular user for other users account' do
      include_context 'with session'
      let(:record) { build_stubbed(:user, name: 'xxx', email: 'xy@example.tld') }
    end

    succeed 'for admin user for own account' do
      include_context 'with admin session'
    end

    succeed 'for admin user for other users account' do
      include_context 'with admin session'
      let(:record) { build_stubbed(:user) }
    end
  end

  describe_rule :new? do
    failed 'for regular user' do
      include_context 'with session'
    end

    succeed 'for admin user' do
      include_context 'with admin session'
    end
  end

  describe_rule :create? do
    specify { expect(:create?).to be_an_alias_of(policy, :new?) }
  end

  describe_rule :edit? do
    succeed 'for admin user for own account' do
      include_context 'with admin session'
      let(:record) { build_stubbed(:user) }
    end

    succeed 'for admin user for other users account' do
      include_context 'with admin session'
      let(:record) { build_stubbed(:user, name: 'xxx', email: 'xy@example.tld') }
    end

    succeed 'for regular user for own account' do
      include_context 'with session'
    end

    failed 'for regular user for other users account' do
      include_context 'with session'
      let(:record) { build_stubbed(:user, name: 'xxx', email: 'xy@example.tld') }
    end
  end

  describe_rule :update? do
    specify { expect(:update?).to be_an_alias_of(policy, :edit?) }
  end

  describe_rule :destroy? do
    succeed 'for admin user for own account' do
      include_context 'with admin session'
    end

    succeed 'for admin user for other users account' do
      include_context 'with admin session'
      let(:record) { build_stubbed(:user) }
    end

    succeed 'for regular user for own account' do
      include_context 'with session'
    end

    failed 'for regular user for other users account' do
      include_context 'with session'
      let(:record) { build_stubbed(:user, name: 'xxx', email: 'xy@example.tld') }
    end

    xfailed 'for root user' do
      skip 'Differentiation between root and admin user not implemted yet'
      include_context 'with admin session'
    end
  end
end
