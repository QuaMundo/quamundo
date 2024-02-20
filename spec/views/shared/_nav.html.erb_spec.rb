# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'shared/_nav.html.erb', type: :view do
  it 'renders partial user_menu' do
    render
    expect(rendered).to have_rendered(partial: 'shared/menus/_user_menu')
  end

  it 'renders partial admin_menu' do
    render
    expect(rendered).to have_rendered(partial: 'shared/menus/_admin_menu')
  end
end
