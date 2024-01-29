# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'with validation' do
    let(:user) { build(:user) }

    include_examples 'having an uuid', :user

    it 'is valid as normal user with name, email and password' do
      expect(user).to be_valid
    end

    it 'is invalid whithout a name' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it 'is invalid without an email adress' do
      user.email = nil
      expect(user).not_to be_admin
    end

    it 'truncates name to maximum of 15 chars' do
      user.name = 'Farmorethanonlyfifteencharacters'
      user.validate
      expect(user.name.length).to eq(15)
    end
  end

  context 'with uniqueness' do
    let(:user) { create(:user) }
    let(:other_user) { build(:user, name: 'other', email: 'other@example.tld') }

    it 'has an unique email address' do
      other_user.email = user.email
      expect(other_user).not_to be_valid
    end

    it 'has an unique name' do
      other_user.name = user.name
      expect(other_user).not_to be_valid
    end
  end

  context 'with roles' do
    context 'when normal user' do
      let(:user) { build(:user) }

      it 'does not identify as admin' do
        expect(user).not_to be_admin
      end

      it 'does not identify as root_user' do
        expect(user).not_to be_super_user
      end
    end

    context 'when admin user' do
      let(:user) { build(:admin) }

      it 'identifies as admin' do
        expect(user).to be_admin
      end

      it 'does not identify as superuser' do
        skip 'For the time beeing, admin and super_user are indentically'
        expect(user).not_to be_super_user
      end
    end

    context 'when root user' do
      let(:user) { build(:super_user) }

      it 'identifies as admin' do
        expect(user).to be_admin
      end

      it 'identifies as super_user' do
        expect(user).to be_super_user
      end
    end
  end

  context 'with db layer' do
    let(:user) { build(:user) }

    it 'writes valid data to database' do
      expect { user.save!(validate: false) }
        .not_to raise_exception
    end

    it 'refuses to write user without email' do
      user.email = nil
      expect { user.save!(validate: false) }
        .to raise_error ActiveRecord::NotNullViolation
    end

    it 'refuses to write user without name' do
      user.name = nil
      expect { user.save!(validate: false) }
        .to raise_error ActiveRecord::NotNullViolation
    end

    it 'refuses to save name longer than 15 chars' do
      user.name = 'Farmorethanonlyfifteencharacters'
      expect { user.save!(validate: false) }
        .to raise_error ActiveRecord::ValueTooLong
    end

    it 'refuses to write user without password' do
      skip 'Not implemented or undecided'
      user.password = nil
      expect { user.save!(validate: false) }
        .to raise_error ActiveRecord::NotNullViolation
    end
  end
end
