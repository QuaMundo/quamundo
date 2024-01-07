# frozen_string_literal: true

require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Quamundo
  # The QuaMundo App - configuration
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Use SQL dump schema
    config.active_record.schema_format = :sql

    # Additional args to pg_dump
    # This should prevent errors when trying to re-create schema public on
    # db:load / db:setup
    # See: https://github.com/rails/rails/issues/38695#issuecomment-763588402
    ActiveRecord::Tasks::DatabaseTasks.structure_dump_flags = ['--clean', '--if-exists']

    # custom configuration (uses `config/quamundo.yml`)
    config.quamundo = config_for(:quamundo) || {
      super_user_name: 'quamundo',
      super_user_email: 'mail@example.tld',
      super_user_password: 'QuaMund0'
    }
  end
end
