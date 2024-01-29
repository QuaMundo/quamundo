# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  context 'with GET /users/sign_in' do
    it 'renders layout session on login' do
      get :new
      expect(response).to render_template(layout: 'layouts/users/sessions')
    end
  end
end
