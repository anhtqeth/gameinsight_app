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
  def fetchAPIData(id,company_type)
    result = gameCompaniesRequest(id,company_type)
    OpenStruct.new(result)
    # result.map{|companies_data| companies_data = OpenStruct.new(companies_data)}
  end
  
  def saveAPIData(id,company_type)
    api_data = fetchAPIData(id,company_type)
    
    unless Company.find_by_external_id(id).nil?
      company = Company.find_by_external_id(id)
      company.games << findGame(id)
      #company.save
      puts "Found Company ID"
      puts company.errors.messages
      updateInvolvedCompanies(company.id,company_type)
      company
    else  
      company = Company.new
      company.external_id = api_data.id
      company.name = api_data.name
      company.description = api_data.description
      #company.url = api_data.url
      company.start_date = api_data.start_date
      company.start_date_category = api_data.start_date_category
      company.games << findGame(id)
      
      company.save
      puts "Not found Company ID"
      puts company.errors.messages
      updateInvolvedCompanies(company.id,company_type)
      company
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
  def updateInvolvedCompanies(id,company_type)
    
    # if InvolvedCompany.find_by_company_id(id).nil?
      
    # else
      involved_company = InvolvedCompany.find_by_company_id(id)
      case company_type
        when 'Publisher'
          involved_company.publisher = true
        when 'Developer'
          involved_company.developer = true
        else
         puts "error in #{company_type}"
      end
      involved_company.save
    # end
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
