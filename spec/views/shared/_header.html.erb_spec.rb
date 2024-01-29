# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'shared/_header.html.erb', type: :view do
  it 'renders nav menu' do
    render
    expect(rendered).to have_rendered(partial: 'shared/_nav')
  end
end
