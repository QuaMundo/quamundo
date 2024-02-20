# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  # FIXME: Maybe possible stubbed version?
  let(:user) { create(:user) }

  context 'with no user is logged in' do
    describe 'GET /users/sign_in' do
      it 'shows login form' do
        get '/users/sign_in'
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /users/sign_in' do
      it 'redirects to worlds index after successfull login' do
        post '/users/sign_in', params: { user: { email: user.email,
                                                 password: user.password } }
        expect(response).to redirect_to('/')
      end

      it 'redirects back to login page after failed login' do
        post '/users/sign_in', params: { user: { email: user.email,
                                                 password: 'wrong pw' } }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'with valid user logged in' do
    include_context 'with session'

    it 'redirects to root path when gointo to login page' do
      get '/users/sign_in'

      expect(response).to redirect_to '/'
    end
  end
end
