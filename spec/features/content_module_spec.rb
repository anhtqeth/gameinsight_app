# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'

# ContentModuleSpec - Used to test function call to Contenful
# Author - Anh Truong
# Date Added - 01 - Oct - 2019

RSpec.feature 'Get Content', type: :feature do
  include ContentModule
  # scenario "Postman Test" do
  #   detail = postmanReq
  #   expect(detail).not_to be_nil
  # end
  scenario 'Fetch Entry' do
    entry = entryRequest('10PCttqTZMbCMna6rBGsvb')
    expect(entry).not_to be_nil
  end

  scenario 'Fetch Post' do
    # post_content = renderRichText(entryRequest('post'))
    # expect(post_content).not_to be_nil
  end

  scenario 'Fetch All Posts' do
    posts = entriesRequest('post')
    expect(posts).not_to be_nil
    posts.each do |arc|
      puts arc.title
    end
  end
  # scenario "Showing game details" do
  #   detail = gamesRequest(55090)
  #   expect(detail).not_to be_nil
  # end
end
