# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'layouts/application.html.erb', type: :view do
  it 'renders partial header' do
    render
    expect(rendered).to have_rendered(partial: 'shared/_header')
  end
  it 'renders partial footer' do
    render
    expect(rendered).to have_rendered(partial: 'shared/_footer')
  end
end
