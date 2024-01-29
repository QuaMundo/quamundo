# frozen_string_literal: true

RSpec.shared_context 'with session' do
  let(:user) { build_stubbed(:user) }

  around do |example|
    sign_in user
    example.run
    sign_out user
  end
end

RSpec.shared_context 'with admin session' do
  let(:user) { build_stubbed(:admin) }

  around do |example|
    sign_in user
    example.run
    sign_out user
  end
end

RSpec.shared_context 'with root session' do
  let(:user) { build_stubbed(:super_user) }

  around do |example|
    sign_in user
    example.run
    sign_out user
  end
end
