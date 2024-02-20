# frozen_string_literal: true

require 'rails_helper'

describe 'POST /users', type: :request do
  let(:params) { { user: attributes_for(:user) } }

  context 'when no user is logged in' do
    it 'redirects to login path' do
      post(users_path, params:)
      expect(response).to redirect_to new_user_session_path
    end

    it 'shows flash alert' do
      post(users_path, params:)
      # FIXME: Check flash message
      expect(flash.alert).not_to be_empty
    end
  end

  context 'when regular user is logged in' do
    include_context 'with session'

    it 'redirects to root_path' do
      post(users_path, params:)
      expect(response).to redirect_to root_path
    end

    it 'shows flash alert' do
      post(users_path, params:)
      # FIXME: Check flash message
      expect(flash.alert).not_to be_empty
    end
  end

  context 'when admin user is logged in' do
    include_context 'with admin session'

    it 'redirects to user index path' do
      post(users_path, params:)
      expect(response).to redirect_to users_path
    end

    it 'shows flash notice' do
      post(users_path, params:)
      # FIXME: Check flash message
      expect(flash.notice).not_to be_empty
    end
  end
end
