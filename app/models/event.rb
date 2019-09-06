class Event < ApplicationRecord
    belongs_to :user
    has_many   :events_attendees, foreign_key: 'attended_event_id'
    has_many   :attendees, through: :events_attendees, source: :attendee
    scope :prev, -> { where('event_date < :current_date', current_date: DateTime.now) }
    scope :upcoming, -> { where('event_date >= :current_date', current_date: DateTime.now) }
    validates :event_date, presence: true
    validates :location, presence: true
    validates :description, presence: true
end
