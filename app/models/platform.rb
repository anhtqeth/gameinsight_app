# frozen_string_literal: true

# == Schema Information
#
# Table name: platforms
#
#  id            :bigint           not null, primary key
#  external_id   :integer
#  abbreviation  :string
#  alt_name      :string
#  generation    :integer
#  name          :string
#  platform_logo :string
#  summary       :text
#  details       :text
#  url           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  slug          :string
#
include ContentModule

class Platform < ApplicationRecord
  has_and_belongs_to_many :games
  # Need to remove some validation below for platform save
  validates :name, presence: true
  validates :external_id, uniqueness: true
  extend FriendlyId
  friendly_id :name, use: :slugged

  def fetchAPIData(id)
    OpenStruct.new(gamesPlatformRequest(id))
  end
  #Call to Contenful to retrieve entry content
  #
  def fetchContentData(name)
    entries = entriesRequest('platform')
    detail = nil
    entries.each do |entry| 
      if entry.name == name
        detail = entry
      end
    end
    detail
  end
  
  # def saveContentData(id)
  #   platform = Platform.find(id)
  #   if platform.details.nil?
  #     content = fetchContentData(platform.name)
  #     platform.summary = content.summary
  #     platform.details = renderRichText(content.description)
  #     platform.save
  #   end
  # end
  def saveContentData    #platform = Platform.find(id)
    if self.details.nil?
      content = fetchContentData(self.name)
      self.summary = content.summary
      self.details = renderRichText(content.description)
      self.save
    end
  end
  
  def saveAPIData(id)
    platform_detail = fetchAPIData(id)

    platform = Platform.new
    platform.external_id = platform_detail.id
    platform.abbreviation = platform_detail.abbreviation
    platform.alt_name = platform_detail.alt_name

    if platform_detail.summary.nil?
      platform.generation = 'Not Applicable' # These string must be located in a resource file for translation
    else
      platform.generation = platform_detail.generation
    end
    platform.name = platform_detail.name
    platform.platform_logo = platform_detail.platform_logo
    if platform_detail.summary.nil?
      platform.summary = 'Not provided' # These string must be located in a resource file for translation
    else
      platform.summary = platform_detail.summary
    end
    platform.save
    puts 'DEBUG --- PLATFORM SAVE'
    puts platform.errors.messages
    platform
  end
end
