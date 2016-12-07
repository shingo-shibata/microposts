class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  validates :age , numericality: { greater_than: 0, less_than: 150 } 
  validates :region , length: { minimum: 0, maximum: 10 } 
  validates :profile , length: { minimum: 0, maximum: 500 } 
end
