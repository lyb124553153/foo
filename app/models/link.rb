class Link < ApplicationRecord
  validates_presence_of :origin_url, :code
  validates_uniqueness_of :code
  validate :original_url_format, unless: proc { |link| link.origin_url.blank? }

  def original_url_format
    errors.add(:base, 'Invalid URL format') if origin_url.start_with?("http://localhost:3000/s/")
    uri = URI.parse(origin_url)
    errors.add(:original_url, 'Invalid URL format') if uri.host.nil?
  end

  def shortened_url
    Rails.application.routes.url_helpers.shortener_url(code: code)
  end
end
