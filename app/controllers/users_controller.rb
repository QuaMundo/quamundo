# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all
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
          # FIXME: Check flash message
          flash.notice = 'success'
          redirect_to users_path
        end
      else
        # FIXME: Check flash message
        flash.alert = 'failed'
        render :new
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        # FIXME: Add flash
        format.html do
          flash.notice = 'success'
          redirect_to root_path
        end
      else
        # FIXME: Add flash
        format.html do
          flash.alert = 'failed'
          render :edit
        end
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      # FIXME: Add flash
      format.html do
        flash.notice = 'success'
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
          .permit(:name, :email, :password, :password_confiramtion)
  end

  def redirect_after_destroy
    return users_path if current_user.admin? && current_user != @user

    new_user_session_path
  end
end
