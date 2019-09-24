class InvolvedCompany < ApplicationRecord
  belongs_to :game, optional: true
  belongs_to :company, optional: true
  
  validates :company_id, :game_id, presence: true
  
  #Scope was used to assgne active record query on certain circumstances
  #For example, below added "AND publisher = true" to the end of the query
 
  scope :supporter, -> { find_by(supporting: true) }
  scope :porter, -> { find_by(porting: true) }
  
  def self.publisher
    publisher_company = self.find_by(publisher: true)
    publisher_company.present? ? publisher_company : nil
  end  
  
  def self.developer
    developer_company = self.find_by(developer: true)
    developer_company.present? ? developer_company : nil
  end  
  
  #cp = Game.find(64)  cp.involved_companies.developer
  
  
end
