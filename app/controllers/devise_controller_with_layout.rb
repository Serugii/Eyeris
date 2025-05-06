class DeviseControllerWithLayout < Devise::SessionsController
  layout 'application'
end