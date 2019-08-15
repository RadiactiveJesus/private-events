class User < ApplicationRecord
  has_secure_password
  validates :email, presence:true, uniqueness:true
  validates :username, presence:true, uniqueness:true
  validates :password, length: {minimum: 8}, allow_blank: false
  before_create{generate_token(:remember_token)}
  has_and_belongs_to_many :events
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

end
