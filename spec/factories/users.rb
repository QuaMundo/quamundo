# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'user' }
    email { 'mail@example.tld' }
    password { '12345678' }
  end

  factory :super_user, class: 'User' do
    id { 0 }
    name { 'quamundo' }
    email { 'quamundo@example.tld' }
    password { '12345678' }
  end
end
