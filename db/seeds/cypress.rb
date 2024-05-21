# frozen_string_literal: true

# redundant check rails environment - should already be done in
# ../../lib/tasks/cypress.rake
raise <<END_OF_MESSAGE unless Rails.env.test?
  This db seed may only be used in testing environment (cypress)
END_OF_MESSAGE

require 'factory_bot_rails'

# ensure super user with id: 0 is present
FactoryBot.create(:super_user)

# ensure std user with id: 1 is present
if (user = User.find_by id: 1)
  user.update!(email: 'mail@example.tld',
               name: 'user',
               password: '12345678',
               password_confirmation: '12345678')
else
  FactoryBot.create(:user,
                    name: 'user',
                    email: 'mail@example.tld',
                    password: '12345678')
end
