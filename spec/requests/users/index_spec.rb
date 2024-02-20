# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /users', type: :request do
  context 'when no user is logged in' do
    it 'redirects to login path' do
      get users_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'shows flash alert' do
      get users_path
      # FIXME: Check flash message
      expect(flash.alert).not_to be_nil
    end
  end

  context 'when regular user is logged in' do
    include_context 'with session'

    it 'redirects to root path' do
      get users_path
      expect(response).to redirect_to root_path
    end

    it 'shows flash alert' do
      get users_path
      # FIXME: Check flash message
      expect(flash.alert).not_to be_nil
    end
  end

  context 'when admin user is logged in' do
    include_context 'with admin session'

    it 'renders users index' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'does not show any flash messages' do
      get users_path
      expect(flash).to be_empty
    end
  end
end
