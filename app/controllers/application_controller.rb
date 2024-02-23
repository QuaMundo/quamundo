# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # force devise authentication
  before_action :authenticate_user!
  before_action :set_locale

  # ensure authorization takes place (ActionPolicy)
  verify_authorized

  rescue_from ActionPolicy::Unauthorized do |ex|
    # ex.result.reasons.details #=> { stage: [:show?] }
    # or with i18n support
    # ex.result.reasons.full_messages #=> ["You do not have access to the stage"]

    flash.alert = t '.not_allowed', details: ex.result.reasons.full_messages
    redirect_to root_path
  end

  def default_url_options
    I18n.default_locale == I18n.locale ? {} : { l: I18n.locale }
  end

  private

  def set_locale
    I18n.locale = params[:l] || locale_from_tld || I18n.default_locale
  end

  def locale_from_tld
    tld = request.host.split('.').last
    I18n.available_locales.map(&:to_s).include?(tld) ? tld : nil
  end
end
