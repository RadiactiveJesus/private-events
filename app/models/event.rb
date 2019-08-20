class Event < ApplicationRecord
    belongs_to :user
    has_many   :events_attendees, foreign_key: 'attended_event_id'
    has_many   :attendees, through: :events_attendees, source: :attendee
end
