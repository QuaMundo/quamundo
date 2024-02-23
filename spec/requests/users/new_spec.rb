# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /users/new', type: :request do
  context 'when no user is logged in' do
    it 'redirects to login path' do
      get new_user_path
      expect(response).to redirect_to new_user_session_path
    end

    it 'shows flash alert' do
      get new_user_path
      expect(flash.alert)
        .to match(I18n.t('devise.failure.unauthenticated'))
    end
  end

  context 'when regular user is logged in' do
    include_context 'with session'

    it 'redirects to root_path' do
      get new_user_path
      expect(response).to redirect_to root_path
    end

    it 'shows flash alert' do
      get new_user_path
      expect(flash.alert)
        .to match(/^#{I18n.t('users.not_allowed').slice!(..10)}/)
    end
  end

  context 'when admin user is logged in' do
    include_context 'with admin session'

    it 'renders new form' do
      get new_user_path
      expect(response).to render_template(:new)
    end

    it 'does not show any flash message' do
      get new_user_path
      expect(flash).to be_empty
    end
  end
end
