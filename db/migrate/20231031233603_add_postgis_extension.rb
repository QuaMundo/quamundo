# frozen_string_literal: true

# Add postgis extension to postgres database
class AddPostgisExtension < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'postgis'
  end
end
