# frozen_string_literal: true

class FetchNewsFeedJob < ApplicationJob
  queue_as :default

  def perform(source); end
end
