# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/edit.html.erb', type: :view do
  before { assign(:user, build_stubbed(:user)) }

  it 'renders partial _form' do
    render
    expect(rendered).to have_rendered(partial: 'users/_form')
  end
end
