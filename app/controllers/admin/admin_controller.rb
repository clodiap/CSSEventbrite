class Admin::AdminController < AdminController

  def index
  	@all_users = User.all
  	@all_events = Event.all
  end
end