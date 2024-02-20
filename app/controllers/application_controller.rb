# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # force devise authentication
  before_action :authenticate_user!

  # ensure authorization takes place (ActionPolicy)
  verify_authorized

  rescue_from ActionPolicy::Unauthorized do |_ex|
    # ex.result.reasons.details #=> { stage: [:show?] }
    # or with i18n support
    # ex.result.reasons.full_messages #=> ["You do not have access to the stage"]

    # FIXME: Add flash messages / i18n
    flash.alert = 'Not allowed'
    redirect_to root_path
  end
end
