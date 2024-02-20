# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/new.html.erb', type: :view do
  it 'renders partial _form' do
    render
    expect(rendered).to have_rendered(partial: 'users/_form')
  end
end
