# frozen_string_literal: true

class Content < ApplicationRecord
  include ErrorHash

  CONTENT_TYPES = %w[html audio video download pdf].freeze

  belongs_to :chapter
  has_one :content_file, dependent: :destroy

  validates :title, length: { maximum: 255 }, allow_blank: false
  validates :content_type, inclusion: { in: CONTENT_TYPES }
end
