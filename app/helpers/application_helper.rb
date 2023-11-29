# frozen_string_literal: true

module ApplicationHelper
  def title
    return t('kibe') unless content_for(:title)

    "#{content_for(:title)} | #{t('kibe')}"
  end

  def flash_class(level)
    case level
    when 'success'
      'max-w-2xl bg-green-300 px-4 py-3 m-auto'
    when 'danger'
      'max-w-2xl bg-red-300 px-4 py-3 m-auto'
    else
      'max-w-2xl bg-blue-300 px-4 py-3 m-auto'
    end
  end
end
