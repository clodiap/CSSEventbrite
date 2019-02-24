class AdminController < ApplicationController
before_action :require_admin

private

  def require_admin
	unless current_user.try(:admin?)
	  flash[:danger] = "Accès non autorisé"
	  redirect_to root_path
	end
  end
end

