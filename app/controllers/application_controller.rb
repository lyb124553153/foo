class ApplicationController < ActionController::Base
 rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
 def default_url_options
  { host: request.host_with_port }
 end

 private

 def record_not_found
  render file: "#{Rails.root}/public/404", layout: true, status: :not_found
 end
end
