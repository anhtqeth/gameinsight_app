class Post < ApplicationRecord
  belongs_to :user
  belongs_to :game
  belongs_to :company
  belongs_to :platform
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