# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PATCH /user/<id>', type: :request do
  let(:user) { build_stubbed(:user) }
  let(:other_user) { build_stubbed(:user) }
  let(:params) { { user: attributes_for(:user) } }

  before do
    allow(User).to receive(:find).and_return(user)
    allow(user).to receive(:update).and_return(true)
  end

  context 'when no user is logged in' do
    it 'redirects to login path' do
      patch(user_path(user), params:)
      expect(response).to redirect_to new_user_session_path
    end

    it 'shows flash alert' do
      patch(user_path(user), params:)
      expect(flash.alert)
        .to match(I18n.t('devise.failure.unauthenticated'))
    end
  end

  context 'when regular user is logged in' do
    include_context 'with session'

    context 'when trying to update own attributes' do
      it 'redirects to root_path' do
        patch(user_path(user), params:)
        expect(response).to redirect_to root_path
      end

      it 'shows flash notice' do
        patch(user_path(user), params:)
        expect(flash.notice)
          .to match(I18n.t('users.update_success', user: user.name))
      end
    end

    context 'when failing to update own attributes' do
      before { allow(user).to receive(:update).and_return(false) }

      it 'rerenders edit form' do
        patch(user_path(user), params:)
        expect(response).to render_template(:edit)
      end

      it 'shows flash alert' do
        patch(user_path(user), params:)
        expect(flash.alert)
          .to match(I18n.t('users.update_failed', user: user.name))
      end
    end

    context 'when trying to update other users attributes' do
      before { allow(User).to receive(:find).and_return(other_user) }

      it 'redirects to root_path' do
        patch(user_path(other_user), params:)
        expect(response).to redirect_to root_path
      end

      it 'shows flash alert' do
        patch(user_path(other_user), params:)
        expect(flash.alert)
          .to match(/^#{I18n.t('users.not_allowed').slice!(..10)}/)
      end
    end
  end

  context 'when admin user is logged in' do
    include_context 'with admin session'

    context 'when trying to update own attributes' do
      it 'renders redirects to root_path' do
        patch(user_path(user), params:)
        expect(response).to redirect_to root_path
      end

      it 'shows flash notice' do
        patch(user_path(user), params:)
        expect(flash.notice)
          .to match(I18n.t('users.update_success', user: user.name))
      end
    end

    context 'when failing to update own attributes' do
      before { allow(user).to receive(:update).and_return(false) }

      it 'rerenders edit form' do
        patch(user_path(user), params:)
        expect(response).to render_template(:edit)
      end

      it 'shows flash alert' do
        patch(user_path(user), params:)
        expect(flash.alert).not_to be_empty
      end
    end

    context 'when trying to update other users attributes' do
      before do
        allow(User).to receive(:find).and_return(other_user)
        allow(other_user).to receive(:update).and_return(true)
      end

      it 'redirects to root_path' do
        patch(user_path(other_user), params:)
        expect(response).to redirect_to root_path
      end

      it 'shows flash notice' do
        patch(user_path(other_user), params:)
        expect(flash.notice)
          .to match(I18n.t('users.update_success', user: other_user.name))
      end
    end

    context 'when failing to update other users attributes' do
      before do
        allow(User).to receive(:find).and_return(other_user)
        allow(other_user).to receive(:update).and_return(false)
      end

      it 'rerenders edit form' do
        patch(user_path(other_user), params:)
        expect(response).to render_template(:edit)
      end

      it 'shows flash alert' do
        patch(user_path(other_user), params:)
        expect(flash.alert)
          .to match(I18n.t('users.update_failed', user: other_user.name))
      end
    end
  end
end
