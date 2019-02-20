class Admin::AdminController < AdminController

  def index
  	@all_users = User.all
  end
end