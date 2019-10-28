class AddAcceptedToEventsAttendees < ActiveRecord::Migration[5.2]
  def change
    add_column :events_attendees, :accepted, :boolean, default: false
    add_column :events_attendees, :declined, :boolean, default: false
  end
end
