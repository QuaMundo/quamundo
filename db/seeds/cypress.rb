# frozen_string_literal: true

# redundant check rails environment - should already be done in
# ../../lib/tasks/cypress.rake
raise <<END_OF_MESSAGE unless Rails.env.test?
  This db seed may only be used in testing environment (cypress)
END_OF_MESSAGE

require 'factory_bot_rails'

FactoryBot.create(:super_user)
FactoryBot.create(:user)
