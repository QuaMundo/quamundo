# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'layouts/users/sessions.html.erb', type: :view do
  it 'does not render header' do
    render
    expect(rendered).not_to have_rendered(partial: 'shared/_header')
  end

  it 'does not render footer' do
    render
    expect(rendered).not_to have_rendered(partial: 'shared/_footer')
  end
end
