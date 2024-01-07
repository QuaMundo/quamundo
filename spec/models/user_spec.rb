# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'is valid as normal user with name, email and password' do
    expect(user).to be_valid
    expect(user).not_to be_admin
    expect(user).not_to be_super_user
    expect { user.save!(validate: false) }
      .not_to raise_exception
  end

  it 'is invalid without name' do
    user.name = nil
    expect(user)
      .not_to be_valid
    expect { user.save!(validate: false) }
      .to raise_exception ActiveRecord::NotNullViolation
  end

  it 'is invalid without email' do
    user.email = nil
    expect(user)
      .not_to be_valid
    expect { user.save!(validate: false) }
      .to raise_exception ActiveRecord::NotNullViolation
  end

  it 'has an unique email' do
    user.save!
    other_user = build(:user, email: user.email)
    expect(other_user).not_to be_valid
    expect { other_user.save!(validate: false) }
      .to raise_exception ActiveRecord::RecordNotUnique
  end

  it 'has an unique name' do
    user.save!
    other_user = build(:user, email: 'xyz@ab.cd')
    expect(other_user).not_to be_valid
    expect { other_user.save!(validate: false) }
      .to raise_exception ActiveRecord::RecordNotUnique
  end

  it 'has a name truncated after 15 characters' do
    pending 'Autom. truncation of name not implemented yet'
    long_name = 'this_is_a_much_too_long_name'
    short_name = long_name.slice(0, 15)
    user = User
           .new(name: long_name, email: 'email6@ab.cd', password: '12345678')
    user.validate!
    expect(user.name).to eq(short_name)
  end

  include_examples 'having an uuid', :user

  it 'gets default super_user with id of zero on db setup' do
    super_user = create(:super_user)
    expect(super_user.id).to be 0
    expect(super_user).to be_admin
    expect(super_user).to be_super_user
    expect(super_user.qm_uuid).to be_an_uuid
  end
end
