# frozen_string_literal: true

# ApplicationHelper
module ApplicationHelper
  def process_flash(type, &)
    return unless flash[type]

    return flash[type] unless block_given?

    (flash[type].is_a?(Array) ? flash[type] : [flash[type]]).each(&)
    nil
  end
end
