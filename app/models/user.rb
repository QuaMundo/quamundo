# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # TODO: Truncate name (automatically)
  # before_validation :truncate_name

  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }
  # TODO: Validate email
  validates :email, presence: true

  def admin?
    # TODO: Provide admin flag or similar to have more than one admin
    # For the time being only super_user is admin
    super_user?
  end

  def super_user?
    id&.zero?
  end
end
