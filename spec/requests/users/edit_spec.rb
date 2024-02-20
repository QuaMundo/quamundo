# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /user/<id>/edit', type: :request do
  before { allow(User).to receive(:find).and_return(user) }

  let(:other_user) { build_stubbed(:user) }

  context 'when no user is logged in' do
    let(:user) { build_stubbed(:user) }

    it 'redirects to login path' do
      get edit_user_path(user)
      expect(response).to redirect_to new_user_session_path
    end

    it 'shows falsh alert' do
      get edit_user_path(user)
      # FIXME: Check flash message
      expect(flash.alert).not_to be_nil
    end
  end

  context 'when regular user is logged in' do
    include_context 'with session'

    context 'when trying to edit own attributes' do
      it 'renders user edit form' do
        get edit_user_path(user)
        expect(response).to render_template(:edit)
      end

      it 'does not show any flash message' do
        get edit_user_path(user)
        expect(flash).to be_empty
      end
    end

    context 'when trying to edit other users attributes' do
      before { allow(User).to receive(:find).and_return(other_user) }

      it 'redirects to root_path' do
        get edit_user_path(other_user)
        expect(response).to redirect_to root_path
      end

      it 'shows flash alert' do
        get edit_user_path(other_user)
        # FIXME: Check flash message
        expect(flash.alert).not_to be_empty
      end
    end
  end

  context 'when admin user is logged in' do
    include_context 'with admin session'

    context 'when trying to edit own attributes' do
      it 'renders user edit form' do
        get edit_user_path(user)
        expect(response).to render_template(:edit)
      end

      it 'does not show any flash message' do
        get edit_user_path(user)
        expect(flash).to be_empty
      end
    end

    context 'when trying to edit other users attributes' do
      before { allow(User).to receive(:find).and_return(other_user) }

      it 'renders user edit form' do
        get edit_user_path(other_user)
        expect(response).to render_template(:edit)
      end

      it 'does not show any flash message' do
        get edit_user_path(user)
        expect(flash).to be_empty
      end
    end
  end
end
