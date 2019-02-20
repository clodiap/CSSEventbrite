module UsersHelper

  def user_profil_completed?
  	current_user.first_name == nil || current_user.last_name == nil ||  current_user.description == nil
  end

  def event_admin?
  	current_user == @event.administrator
  end

  def event_attendee?
  @event.attendees.include?(current_user)
  end

end
