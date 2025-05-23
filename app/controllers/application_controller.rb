class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  rescue_from ActionController::RoutingError, with: :redirect_to_root
  rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_root

  def redirect_to_root
    flash[:alert] = "Сторінку не знайдено. Ви були перенаправлені на головну."
    redirect_to root_path
  end
end
