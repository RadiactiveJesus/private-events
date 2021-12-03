class CreateEventsAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :events_attendees do |t|
      t.integer :attendee_id
      t.integer :attended_event_id
      t.timestamps

      
    end
    add_foreign_key :events_attendees, 
                    :events, 
                    column: :attended_event_id

    add_index :events_attendees, :attended_event_id

    add_foreign_key :events_attendees, 
                    :events, 
                    column: :attendee_id

    add_index :events_attendees, :attendee_id
  end
end
