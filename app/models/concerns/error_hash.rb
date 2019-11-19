module ErrorHash
  extend ActiveSupport::Concern

  # module ClassMethods
  #
  # end

  def errors_hash
    errors_h = {}
    errors.messages.each do |key, value|
      errors_h[key] = value.to_sentence
    end
    errors_h
  end
end
