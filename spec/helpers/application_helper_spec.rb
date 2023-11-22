# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#title' do
    it 'returns default title when content_for(:title) is not set' do
      expect(helper.title).to eq(I18n.t('kibe'))
    end

    it 'returns combined title when content_for(:title) is set' do
      title_content = 'Custom Title'
      helper.content_for(:title, title_content)
      expect(helper.title).to eq("#{title_content} | #{I18n.t('kibe')}")
    end
  end
end
