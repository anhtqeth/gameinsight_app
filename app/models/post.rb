class Post < ApplicationRecord
  
  belongs_to :user, optional: true
  belongs_to :game,  optional: true
  belongs_to :company,  optional: true
  belongs_to :platform,  optional: true
  
  enum status: [:DRAFT, :ARCHIVED, :PUBLISHED]
  
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  include ContentModule
  
  def fetchCMSPost(id)
    entryRequest(id)
  end
  
  def saveCMSPost(id)
    post_data = fetchCMSPost(id)
    Post.create(name: post_data.title, feature_img: post_data.feature_image.url,
    content: renderRichText(post_data.content))
  end
  
  def renderPost(content)
    renderRichText(content)
  end
  
end

# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  name        :string
#  feature_img :string
#  status      :integer
#  user_id     :bigint
#  game_id     :bigint
#  company_id  :bigint
#  platform_id :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  content     :text
#