# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Worlds', type: :request do
  context 'without user logged in' do
    describe 'GET /' do
      it 'shows root path to everybody' do
        get '/'
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /index' do
      it 'shows a list of public readable worlds' do
        skip 'Not implemented yet'
      end
    end
  end

  context 'with user logged in' do
    skip 'Not implemented yet'
  end
end
