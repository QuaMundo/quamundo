# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.order(:name)
    authorize! @users
  end

  def new
    @user = User.new
    authorize! @user
  end

  def edit; end

  def create
    @user = User.new(user_params)
    authorize! @user
    respond_to do |format|
      if @user.save
        format.html do
          flash.notice = t '.create_success', user: @user.name
          redirect_to users_path
        end
      else
        flash.now[:alert] = t '.create_failed', user: @user.name
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)

        # don't log out user after profile update
        bypass_sign_in(@user) unless current_user != @user

        format.html do
          flash.notice = t '.update_success', user: @user.name
          redirect_to root_path
        end
      else
        format.html do
          flash.now[:alert] = t '.update_failed', user: @user.name
          render :edit, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        flash.notice = t '.destroy_success', user: @user.name
        redirect_to redirect_after_destroy
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize! @user
  end

  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation)
  end

  def redirect_after_destroy
    return users_path if current_user.admin? && current_user != @user

    new_user_session_path
  end
end
