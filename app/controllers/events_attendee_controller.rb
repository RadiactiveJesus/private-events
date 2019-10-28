class EventsAttendeeController < ApplicationController
  before_action :logged_in_user, only: %i[edit update]
  before_action :correct_attendee, only: %i[edit update]
  # Pulls the invitation and shows the event information to the user. A user
  # can either accept or decline.
  def edit
    @events_attendee = Events_Attendee.find(params[:id])
    @event = Event.find(@events_attendee.attended_event_id)
    @going = @event.attendees.where('accepted AND NOT declined')
    @not_going = @event.attendees.where('NOT accepted AND declined')
  end

  # Update the status of the invitation to either accepted or declined. The edit
  # form uses radio buttons so only one selection can be made at a time.
  def update
    @events_attendee = Events_Attendee.find(params[:id])
    @event = Event.find(@events_attendee.attended_event_id)

    if accepted?
      @events_attendee.update_column(:accepted, true)
      flash[:success] = 'You are now attending ' + @event.location + '.'
    else
      @events_attendee.update_column(:declined, true)
      message = 'You declined the invitation to ' + @event.location + '.'
      flash[:warning] = message
    end

    redirect_to invitations_path
  end

  private

  def accepted?
    params[:events_attendee][:accepted] == 'true'
  end

  def correct_attendee
    @events_attendee = Events_Attendee.find(params[:id])
    @attendee = User.find(@events_attendee.attendee_id)
    redirect_to root_url unless current_user?(@attendee)
  end
end
end
