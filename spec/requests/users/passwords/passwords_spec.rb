# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Passwords', type: :request do
  describe 'GET /users/passwords/new' do
    it 'shows password form' do
      get '/users/password/new'
      expect(response).to have_http_status(:success)
    end
  end

  # FIXME: Do it for other http verbs, too
end
