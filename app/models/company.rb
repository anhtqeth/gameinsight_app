class Company < ApplicationRecord
  #TODO- Enable slug when save success
  #TODO - Code smell here, this call to API every time game is saved
  #even when the company already exist in db
  
  # extend FriendlyId
  # friendly_id :name, use: :slugged
  has_many :involved_companies
  has_many :games, :through => :involved_companies
  
  validates :external_id, uniqueness: true
  
  enum start_date_category: [:YYYYMMMMDD, :YYYYMMMM, 
  :YYYY, :YYYYQ1, :YYYYQ2, :YYYYQ3, :YYYYQ4, :TBD]
  
  #id is game_exernal_id
  def fetchAPIData(id)
    result = gameCompaniesRequest(id)
    OpenStruct.new(result)
    # result.map{|companies_data| companies_data = OpenStruct.new(companies_data)}
  end
  
  def saveAPIData(id)
     companies = involvedCompaniesRequest(id)
     game_id = findGame(id)
    companies.each do |corp|
      unless Company.find_by_external_id(corp[:id]).nil?
        puts "Find Company ID"
        company = Company.find_by_external_id(corp[:id])
        updateInvolvedCompanies(game_id,company.id,corp[:type])
      else
        puts "Not found Company ID"
        company = Company.new
        api_data = fetchAPIData(corp[:id])
        
        company.external_id = api_data.id
        company.name = api_data.name
        company.description = api_data.description
        #company.url = api_data.url
        company.start_date = api_data.start_date
        company.start_date_category = api_data.start_date_category
        company.save
        puts company.errors.messages
        updateInvolvedCompanies(game_id,company.id,corp[:type])
        
      end
    end
    
  end
  
  #TODO - Work on this later
  # def duplicatesDestroy(title)
  #   dup_list = Game.where(name: title).group_by(&:name)
  #   dup_list.values.each do |dup|
  #     dup.pop #leave one
  #     dup.each(&:destroy) #destroy other
  #   end
  # end
  
  private
  
  def updateInvolvedCompanies(game_id,corp_id,company_type)
    case company_type
      when 'Publisher'
        InvolvedCompany.create(publisher: true, game_id: game_id, company_id: corp_id)
      when 'Developer'
        InvolvedCompany.create(developer: true, game_id: game_id, company_id: corp_id)
      when 'Supporter'
        InvolvedCompany.create(supporting: true, game_id: game_id, company_id: corp_id)
      when 'Porting'
        InvolvedCompany.create(porting: true, game_id: game_id, company_id: corp_id)
      else
       puts "error in #{company_type}"
    end
  end
  
  def findGame(ex_id)
    if Game.find_by_external_id(ex_id)
      Game.find_by_external_id(ex_id)
    else
      game = Game.new
      game.saveAPIData(ex_id)
    end
  end
  
end
