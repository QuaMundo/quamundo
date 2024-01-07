# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do
  login_user

  context 'with GET /users/password/edit' do
    it 'renders layout application' do
      skip 'FIXME: to be implemented'
      get :edit
      expect(response).to render_template(layout: 'layouts/application')
    end
  end
end
