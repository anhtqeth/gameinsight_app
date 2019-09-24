class InvolvedCompany < ApplicationRecord
  belongs_to :game, optional: true
  belongs_to :company, optional: true
  
  validates :company_id, :game_id, presence: true
  
  #Scope was used to assgne active record query on certain circumstances
  #For example, below added "AND publisher = true" to the end of the query
  #
  scope :publisher, -> { find_by(publisher: true) }
  scope :developer, -> { find_by(developer: true) }
  scope :supporter, -> { find_by(supporting: true) }
  scope :porter, -> { find_by(porting: true) }
  
end
