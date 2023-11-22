# frozen_string_literal: true

module ApplicationHelper
  def title
    return t('kibe') unless content_for(:title)

    "#{content_for(:title)} | #{t('kibe')}"
  end
end
