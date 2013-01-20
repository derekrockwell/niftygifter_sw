require File.expand_path('../boot', __FILE__)
require 'pp'
require 'rails/all'
require 'uri'
require 'amazon/ecs'
require 'twilio-ruby'
if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

Amazon::Ecs.options = {
  :associate_tag => ENV["ASSOCIATE_TAG"],
  :AWS_access_key_id => ENV["AWS_ACCESS_KEY"],       
  :AWS_secret_key => ENV["AWS_SECRET_KEY"]
}


module NiftyGifter
  class Application < Rails::Application

    config.autoload_paths += %W(#{config.root}/lib)


    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true

    config.active_record.whitelist_attributes = true

    # Enable the asset pipeline
    config.assets.enabled = true        
    
    # Add the fonts path
    config.assets.paths << "#{Rails.root}/app/assets/font"    
    # Precompile additional assets
    config.assets.precompile += %w( .svg .eot .woff .ttf )

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.1'
end
end
