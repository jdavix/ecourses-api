# frozen_string_literal: true

class Course < ApplicationRecord
  include ErrorHash

  belongs_to :user
  has_many :chapters

  validates :name, presence: true
end
