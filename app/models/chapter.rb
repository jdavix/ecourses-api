# frozen_string_literal: true

class Chapter < ApplicationRecord
  include ErrorHash

  belongs_to :course
  has_many :contents

  validates :title, length: { maximum: 255 }, allow_blank: false
end
