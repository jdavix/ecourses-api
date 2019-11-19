module TokenAuthenticable
  extend ActiveSupport::Concern

  included do
    after_create :assign_auth_token!
  end

  # module ClassMethods
  #
  # end

  def assign_auth_token!
    # Probability of getting the same token with SecureRandom
    # is so vanishingly small that it is virtually zero,
    # but I validate uniqueness with database constrian
    # and attempt 5 times to get a new uniq token.
    update_column(:auth_token, SecureRandom.urlsafe_base64(24))
  rescue ActiveRecord::RecordNotUnique => e
    # Rescuing uniq column database constrain and
    # attempting to produce a new token
    @attempts = @attempts.to_i + 1
    retry if @attempts < 5
    raise e, 'Retries exhausted attempting to generate uniq session token'
  end
end
