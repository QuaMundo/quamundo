# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name, 1) { |n| "user_#{n}" }
    email { "#{name}@email.tld" }
    password { '12345678' }
  end

  # FIXME: Differentiate between super_user and admin
  factory :super_user, class: 'User', aliases: [:admin] do
    id { 0 }
    name { 'quamundo' }
    email { 'quamundo@example.tld' }
    password { '12345678' }
  end
end
