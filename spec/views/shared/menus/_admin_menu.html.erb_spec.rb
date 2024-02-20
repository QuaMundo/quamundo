# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'shared/menus/_admin_menu.html.erb', type: :view do
  context 'when no user is logged in' do
    it 'does not show admin menu' do
      render
      assert_select 'menu#admin_menu', count: 0
    end
  end

  context 'when logged in as regular user' do
    let(:user) { build_stubbed(:user) }

    before { allow(view).to receive(:current_user).and_return(user) }

    it 'does not show admin menu' do
      render
      assert_select 'menu#admin_menu', count: 0
    end
  end

  context 'when logged in as admin user' do
    let(:user) { build_stubbed(:admin) }

    before { allow(view).to receive(:current_user).and_return(user) }

    it 'shows admin menu' do
      render
      assert_select 'menu#admin_menu'
    end

    it 'shows user index link' do
      render
      assert_select 'a[href=?]', users_path
    end

    it 'shows add user link' do
      render
      assert_select 'a[href=?]', new_user_path
    end

    it 'does not show any further link' do
      render
      assert_select 'a', count: 2
    end
  end
end
