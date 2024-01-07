# frozen_string_literal: true

# seed data for production environment

# create superuser with id of '0'
unless User.exists?(0)
  Rails.logger.info('!!! Intially creating super_user with id 0')
  User.create!(
    id: 0,
    name: Rails.configuration.quamundo[:super_user_name],
    email: Rails.configuration.quamundo[:super_user_email],
    password: Rails.configuration.quamundo[:super_user_password]
  )
end
