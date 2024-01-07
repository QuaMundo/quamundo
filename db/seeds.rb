# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Provide seeds per environment; see:
# https://gist.github.com/servel333/47f6cca9e51497aeefab

['all', Rails.env].each do |seed|
  seed_file = Rails.root.join('db', 'seeds', "#{seed}.rb")
  Rails.logger.debug '*** Loading seed data ***'
  if File.exist?(seed_file)
    Rails.logger.debug "* Loading #{seed} seed data *"
    require seed_file
  else
    Rails.logger.debug "--- Seed for env #{seed} not found; skipping ---"
  end
  Rails.logger.debug '*** finished loading seed data ***'
end
