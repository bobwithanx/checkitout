class ApplicationController < ActionController::Base
  include Pagy::Backend
  protect_from_forgery with: :exception

  # in application_controller.rb
  before_action :set_where_am_i
  def set_where_am_i
    @where_am_i = "#{controller_name}/#{action_name}"
  end
end
