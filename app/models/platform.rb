class Platform < ApplicationRecord
  has_and_belongs_to_many :games
  validates :name,:summary,:abbreviation,:generation, presence: true
  validates :external_id,uniqueness: true
  
  def fetchAPIData(id)
    OpenStruct.new(gamesPlatformRequest(id))
  end
  
  def saveAPIData(id)
    platform_detail = fetchAPIData(id)
    
    platform = Platform.new
    platform.external_id = platform_detail.id
    platform.abbreviation = platform_detail.abbreviation
    platform.alt_name = platform_detail.alt_name
    
    if platform_detail.summary.nil?
      platform.generation = "Not Applicable" #These string must be located in a resource file for translation
    else
      platform.generation = platform_detail.generation
    end
    platform.name = platform_detail.name
    platform.platform_logo = platform_detail.platform_logo
    if platform_detail.summary.nil?
      platform.summary = "Not provided" #These string must be located in a resource file for translation
    else
      platform.summary = platform_detail.summary
    end
    platform.save
    
    platform
  end
  
end