class Admin::BaseController < ApplicationController
  before_action :require_admin, only: :disable
  before_action :require_merchant_admin, only: :enable
end
