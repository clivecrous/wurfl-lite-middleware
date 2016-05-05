require 'wurfl-lite-middleware/version'
require 'wurfl-lite'

class WURFL
  class Middleware
    def initialize( app, options = {} )
      @app = app

      # Try to get the location from either parameters or environment
      location = options[:wurfl_xml] || ENV['WURFL_XML']
      @wurfl = location.nil? ? WURFL.new : WURFL.new( location )

      # Cache for a year by default
      @ttl = options[:cache_ttl] || 1.year

      # Configure the object
      @wurfl.match_threshold = options[:match_threshold] if options[:match_threshold] 
    end

    def call( env )
      dup._call(env)
    end

    def _call(env)
      @env = env

      if browser = Rails.cache.read(cache_key)
        @env[ 'WURFL' ] = browser
      else
        browser = @wurfl[ user_agent ]

        Rails.cache.write(cache_key, browser, :expires_in => @ttl, :race_condition_ttl => 10.seconds)
        @env[ 'WURFL' ] = browser
      end

      @app.call(@env)
    end

    def user_agent
      @env[ 'HTTP_USER_AGENT' ] || 'unknown'
    end

    def cache_key
      "browser:#{user_agent}"
    end
  end
end
