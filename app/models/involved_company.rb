class InvolvedCompany < ApplicationRecord
  belongs_to :game, optional: true
  belongs_to :company, optional: true
  
  #Scope was used to assgne active record query on certain circumstances
  #For example, below added "AND publisher = true" to the end of the query
  #
  scope :publisher, -> { where(publisher: true) }
  scope :developer, -> { where(developer: true) }
  scope :supporter, -> { where(supporting: true) }
  scope :porter, -> { where(porting: true) }
  
end
