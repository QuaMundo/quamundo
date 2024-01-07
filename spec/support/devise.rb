# frozen_string_literal: true

module ControllerMacros
  def login_admin
    before do
      # @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryBot.create(:admin)
    end
  end

  def login_user
    before do
      # @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryBot.create(:user)
    end
  end
end

RSpec.configure do |config|
  # enable sign_in/sign_out in specs
  config.include Devise::Test::IntegrationHelpers

  # include devise test helpers for controllers and views
  config.include Devise::Test::ControllerHelpers, type: :controller
  # FIXME: avoid redundancy with above?
  config.include Devise::Test::ControllerHelpers, type: :view

  # provide macros for controller to login user/admin
  config.extend ControllerMacros, type: :controller

  # devise_mappings are set in router - so set manually if router is
  # skipped (like in controller tests)
  config.before(:example, type: :controller) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end
end
