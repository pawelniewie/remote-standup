module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :generate_token
    before_save :generate_token
  end

  protected

  def generate_token
    if self.token.nil? or self.token.empty?
      self.token = loop do
        random_token = SecureRandom.urlsafe_base64(8, false)
        break random_token unless self.class.exists?(token: random_token)
      end
    end
  end
end