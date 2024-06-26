# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE /user/<id>', type: :request do
  let(:user) { build_stubbed(:user) }
  let(:other_user) { build_stubbed(:user) }

  before do
    allow(User).to receive(:find).and_return(user)
    allow(user).to receive(:destroy).and_return(true)
    allow(other_user).to receive(:destroy).and_return(true)
  end

  context 'when no user is logged in' do
    it 'redirects to login path' do
      delete user_path(user)
      expect(response).to redirect_to new_user_session_path
    end

    it 'shows flash alert' do
      delete user_path(user)
      expect(flash.alert).to match(I18n.t('devise.failure.unauthenticated'))
    end
  end

  context 'when logged in as regular user' do
    include_context 'with session'

    context 'when trying to destroy own account' do
      it 'redirects to login path' do
        delete user_path(user)
        expect(response).to redirect_to new_user_session_path
      end

      it 'shows flash notice' do
        delete user_path(user)
        expect(flash.notice)
          .to match(I18n.t('users.destroy_success', user: user.name))
      end
    end

    context 'when trying to destroy other users account' do
      before { allow(User).to receive(:find).and_return(other_user) }

      it 'redirects to root_path' do
        delete user_path(other_user)
        expect(response).to redirect_to root_path
      end

      it 'shows flash alert' do
        delete user_path(other_user)
        # FIXME: Helper for regexp
        expect(flash.alert)
          .to match(/^#{I18n.t('users.not_allowed').slice!(..10)}/)
      end
    end
  end

  context 'when logged in as admin user' do
    include_context 'with admin session'

    context 'when trying to destroy own account' do
      it 'redirects to login path' do
        delete user_path(user)
        expect(response).to redirect_to new_user_session_path
      end

      it 'shows flash notice' do
        delete user_path(user)
        expect(flash.notice)
          .to match(I18n.t('users.destroy_success', user: user.name))
      end
    end

    context 'when trying to destroy other users account' do
      before { allow(User).to receive(:find).and_return(other_user) }

      it 'redirects to user index' do
        delete user_path(other_user)
        expect(response).to redirect_to users_path
      end

      it 'shows flash notice' do
        delete user_path(other_user)
        expect(flash.notice)
          .to match(I18n.t('users.destroy_success', user: other_user.name))
      end
    end
  end
end
