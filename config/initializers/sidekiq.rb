# frozen_string_literal: true

# rails_root = Rails.root || File.dirname(__FILE__) + '/../..'
# rails_env  = Rails.env || 'development'

# redis_config = YAML.load_file(rails_root.to_s + '/config/redis.yml')
# redis_config.merge! redis_config.fetch(Rails.env, {})
# redis_config.symbolize_keys!

# Sidekiq.configure_server do |config|
#   config.redis = { url: "redis://#{redis_config[:host]}:#{redis_config[:port]}/12" }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: "redis://#{redis_config[:host]}:#{redis_config[:port]}/12" }
# end

if Rails.env.development?
  Sidekiq.configure_server do |config|
    config.redis = { url: 'redis://localhost:6379' }
  end
end

if Rails.env.production?
  Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDISTOGO_URL'], size: 2 }
  end

  Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDISTOGO_URL'], size: 20 }
  end
end

# Old configuration in dev
# Sidekiq.configure_server do |config|
#   config.redis = { url: 'redis://localhost:6379/0'  }
# end

# Sidekiq.configure_client do |config|
#   config.redis = { url: 'redis://localhost:6379/0'  }
# end
