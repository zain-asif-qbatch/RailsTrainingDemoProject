class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def page_not_found
    render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
  end
end
