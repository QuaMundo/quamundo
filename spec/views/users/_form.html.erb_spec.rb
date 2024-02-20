# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/_form.html.erb', type: :view do
  context 'when rendered from new request' do
    before do
      assign(:user, build_stubbed(:user))
      render
    end

    specify { assert_select 'input#user_email' }
    specify { assert_select 'input#user_name' }
    specify { assert_select 'input#user_password' }
    specify { assert_select 'input#user_password_confirmation' }
    specify { assert_select 'input[type="submit"]' }
  end

  context 'when rendered from edit request'
end
