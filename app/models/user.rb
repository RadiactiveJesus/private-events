class User < ApplicationRecord
  has_secure_password
  validates :email, presence:true, uniqueness:true
  validates :username, presence:true, uniqueness:true
  validates :password, length: {minimum: 8}, allow_blank: false
  before_create{generate_token(:remember_token)}
  has_many :events, foreign_key: 'user_id', class_name: 'Event'
  has_many :event_attendees, :foreign_key => "attendee_id", :class_name => "EventsAttendee"
  has_many :attended_events, through: :event_attendees, source: :attended_event
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
      self[column] = User.digest(self[column])
    end while User.exists?(column => self[column])
  end

  def previous_events
    attended_events.where('event_date < :current_date AND accepted',
                          current_date: DateTime.now)
  end

  def upcoming_events
    attended_events.where('event_date >= :current_date AND accepted',
                          current_date: DateTime.now)
  end
  
end
