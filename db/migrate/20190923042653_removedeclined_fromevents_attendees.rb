class RemovedeclinedFromeventsAttendees < ActiveRecord::Migration[5.2]
  def change
    remove_column :events_attendees, :declined, :boolean
  end
end
