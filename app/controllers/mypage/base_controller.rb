class Mypage::BaseController < ApplicationController
  before_action :require_login
  layout 'mypage/layouts/application'
end
