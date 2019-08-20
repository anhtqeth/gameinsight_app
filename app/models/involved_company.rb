class InvolvedCompany < ApplicationRecord
  belongs_to :game
  belongs_to :company
  
  #Scope was used to assgne active record query on certain circumstances
  #For example, below added "AND publisher = true" to the end of the query
  #
  scope :publisher, -> { where(publisher: true) }
  scope :developer, -> { where(developer: true) }
  scope :supporter, -> { where(supporting: true) }
  scope :porter, -> { where(porting: true) }
  
end
