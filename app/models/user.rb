class User < ApplicationRecord
  #TODO - Utilize Devise feature when things are done for USER
  #TODO - Add Index to other model as well
  #TODO - Check to see if uiqueness is needed on other model as well
  #TODO - Utilize before_save on other models
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, 
  format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: {minimum: 8}  
  
  
  
end
