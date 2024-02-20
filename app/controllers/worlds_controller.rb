# frozen_string_literal: true

class WorldsController < ApplicationController
  # FIXME: Temp. entry. REFACTOR THIS!!!
  skip_before_action :authenticate_user!, only: :index
  skip_verify_authorized

  def index; end
end
