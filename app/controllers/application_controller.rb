class ApplicationController < ActionController::Base
  include Pagy::Backend
  add_flash_types :primary, :success, :warning, :danger
end
