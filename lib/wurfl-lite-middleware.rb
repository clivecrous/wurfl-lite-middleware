require 'wurfl-lite-middleware/version'
require 'wurfl-lite'

class WURFL
  class Middleware
    def initialize( app, options = {} )
      @app = app

      # Try to get the location from either parameters or environment
      location = options.delete(:wurfl_xml) || ENV['WURFL_XML']
      @wurfl = location.nil? ? WURFL.new : WURFL.new( location )

      # Configure the object
      @wurfl.match_threshold = options[:match_threshold] if options[:match_threshold] 
    end
    def call( env )
      env['WURFL'] = @wurfl[ env[ 'HTTP_USER_AGENT' ] ]
      @app.call( env )
    end
  end
end
