class Users::SessionsController < Devise::SessionsController
  layout "application"
end

class Users::RegistrationsController < Devise::RegistrationsController
  layout "application"
end
