# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'shared/menus/_user_menu.html.erb', type: :view do
  let(:user) { build_stubbed(:user) }

  context 'when no user is logged in' do
    it 'shows only login link' do
      render
      assert_select 'a[href=?]', new_user_session_path
    end

    it 'does not show any further link' do
      render
      assert_select 'a', count: 1
    end
  end

  context 'when user is logged in' do
    before { allow(view).to receive(:current_user).and_return(user) }

    it 'shows edit profile link' do
      render
      assert_select 'a[href=?]', edit_user_path(user)
    end

    it 'shows logout link' do
      render
      assert_select 'a[href=?]', destroy_user_session_path
    end

    it 'does not show further links' do
      render
      assert_select 'a', count: 2
    end
  end
end
