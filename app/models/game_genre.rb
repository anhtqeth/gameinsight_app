class GameGenre < ApplicationRecord
  has_and_belongs_to_many :games
  validates :name,:description, presence: true
  validates :name,uniqueness: true
  
  
  
end
