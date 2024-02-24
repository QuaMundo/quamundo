# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  before_validation :truncate_name

  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }
  validates :password,
            confirmation: true,
            length: { minimum: 8 }
  validates :password_confirmation, presence: true
  # TODO: Validate email
  validates :email, presence: true, uniqueness: true

  def admin?
    # TODO: Provide admin flag or similar to have more than one admin
    # For the time being only super_user is admin
    super_user?
  end

  def super_user?
    id&.zero?
  end

  def truncate_name
    name&.slice!(15..)
  end
end
