# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'shared/_nav.html.erb', type: :view do
  let(:user) { nil }

  before { allow(view).to receive(:current_user).and_return(user) }

  it 'renders partial user_menu' do
    render
    expect(rendered).to have_rendered(partial: 'shared/menus/_user_menu')
  end

  it 'renders partial admin_menu' do
    admin = build(:admin)
    allow(view).to receive(:current_user).and_return(admin)
    render
    expect(rendered).to have_rendered(partial: 'shared/menus/_admin_menu')
  end

  context 'when no user is logged in' do
    it 'renders user menu' do
      render
      expect(rendered).to have_rendered(partial: 'shared/menus/_user_menu')
    end

    it 'does not render admin menu' do
      render
      expect(rendered).not_to have_rendered(partial: 'shared/menus/_admin_menu')
    end
  end

  context 'when regular user is logged in' do
    let(:user) { build_stubbed(:user) }

    it 'renders user menu' do
      render
      expect(rendered).to have_rendered(partial: 'shared/menus/_user_menu')
    end

    it 'does not render admin menu' do
      render
      expect(rendered).not_to have_rendered(partial: 'shared/menus/_admin_menu')
    end
  end

  context 'when admin user is logged in' do
    let(:user) { build_stubbed(:admin) }

    it 'renders user menu' do
      render
      expect(rendered).to have_rendered(partial: 'shared/menus/_user_menu')
    end

    it 'does not render admin menu' do
      render
      expect(rendered).to have_rendered(partial: 'shared/menus/_admin_menu')
    end
  end
end
