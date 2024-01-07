# frozen_string_literal: true

# custom rake task to seed db data for cypress tests
namespace :db do
  namespace :seed do
    desc 'Load seed data for cypress test runs'

    task cypress: :environment do
      unless Rails.env.test?
        puts 'This task is only available in test environment'
        exit
      end

      seed_file = Rails.root.join('db/seeds/cypress.rb').to_s
      Rails.logger.debug "Seeding #{seed_file} ..."
      load(seed_file) if File.exist?(seed_file)
    end
  end
end
