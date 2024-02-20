# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user routes', type: :routing do
  let(:user) { build_stubbed(:user) }

  it 'has no user show route' do
    expect(get: "/users/#{user.id}").not_to be_routable
  end
end
