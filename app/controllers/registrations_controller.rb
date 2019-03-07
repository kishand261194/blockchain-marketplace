class RegistrationsController < Devise::RegistrationsController
before_action :authenticate_user!, :redirect_unless_admin,  only: [:new, :create]
skip_before_action :require_no_authentication

private
def redirect_unless_admin
  unless current_user.try(:admin?)
    flash[:error] = "Only admins can do that"
    redirect_to root_path
  end
end

def sign_up(resource_name, resource)
  true
end
 protected
  def after_sign_up_path_for(resource)
    '/products' # Or :prefix_to_your_route
  end
  def after_sign_out_path_for(resource_or_scope)
    '/user/sign_in'
  end
end
