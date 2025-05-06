class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:dashboard]

  def index
    # доступна для всіх
  end

  def dashboard
    # доступна лише для авторизованих користувачів
  end
end
