# frozen_string_literal: true

class QuamundoFormBuilder < ActionView::Helpers::FormBuilder
  TEXT_FIELD_CSS_CLASSES = %w[
    px-0
    pb-1
    pt-3
    border-0
    border-b-2
    border-gray-300
    peer
    w-full
    ring-0
    focus:ring-0
    focus:border-b2
    focus:border-b-gray-400
    placeholder:text-transparent
  ].freeze
  LABEL_CSS_CLASSES = %w[
    bg-white
    not-italic
    text-base
    absolute
    left-0
    top-2
    peer-placeholder-shown:text-gray-400
    peer-placeholder-shown:text-base
    peer-placeholder-shown:top-2
    peer-placeholder-shown:not-italic
    peer-focus:top-0
    peer-focus:text-xs
    peer-focus:text-blue-400
    peer-focus:not-italic
    [&:not(:empty)]:top-0
    [&:not(:empty)]:text-xs
    [&:not(:empty)]:italic
    [&:not(:empty)]:text-gray-300
  ].freeze

  def text_field_with_label(method, options = {})
    # FIXME: OPTIMIZE: make class options available - for now only css classes
    # defined in constants are used, custom classes should be mergeable
    # Differentiate between text_field and label options/classes
    text_field = @template
                 .text_field(@object_name, method,
                             text_field_options(method, options))
    label = @template
            .label(@object_name, method, label_options(options))

    text_field + label
  end

  private

  def label_options(options)
    objectify_options(options.except(:type).merge(label_css_classes))
  end

  def text_field_options(method, options)
    objectify_options(options
      .clone
      .merge(text_field_css_classes)
      .merge({ placeholder: method })
      .merge(text_field_type(options)))
  end

  def text_field_type(options)
    { type: options.fetch(:type, 'text') }
  end

  def label_css_classes
    { class: LABEL_CSS_CLASSES }
  end

  def text_field_css_classes
    { class: TEXT_FIELD_CSS_CLASSES }
  end
end
