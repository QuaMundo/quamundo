# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index.html.erb', type: :view do
  # non-admin users should be redirected by request
  let(:user) { build_stubbed(:admin) }
  let(:user_list) { build_stubbed_list(:user, 3) }
  let(:all_users) { [*user_list, user] }

  before do
    allow(view).to receive(:current_user).and_return(user)
    assign(:users, all_users)
    render
  end

  specify { all_users.each { |u| expect(rendered).to match(/#{u.name}/) } }
  specify { all_users.each { |u| expect(rendered).to match(/#{u.email}/) } }
  specify { all_users.each { |u| assert_select 'a[href=?]', edit_user_path(u) } }

  specify do
    all_users.each do |u|
      assert_select 'a[href=?][data-method="delete"]', user_path(u)
    end
  end
end
