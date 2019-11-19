# frozen_string_literal: true

class User < ApplicationRecord
  include ErrorHash
  include TokenAuthenticable

  has_many :courses
end
