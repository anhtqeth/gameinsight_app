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
require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'can fetch entry from contenful' do
    arc = Post.new
    result = arc.fetchCMSPost('10PCttqTZMbCMna6rBGsvb')
    expect(result).not_to be_nil
  end

  it 'can save post from CMS' do 
    
  end
  
  it 'can render rich text' do 
    arc = Post.new
    expect(arc.renderRichText).no_to be_nil
  end
  
    
  it 'can create a new post' do

  end
  
  it 'can attach an image' do 
    
    
    
  end
  
end
