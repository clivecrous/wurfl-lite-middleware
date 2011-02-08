require 'wurfl-lite-middleware/version'
require 'wurfl-lite'

class WURFL
  class Middleware
    def initialize( app )
      @app = app
      @wurfl = ENV.has_key?( 'WURFL_XML' ) ? WURFL.new( ENV[ 'WURFL_XML' ] ) : WURFL.new
    end
    def call( env )
      env['WURFL'] = @wurfl[ env[ 'HTTP_USER_AGENT' ] ]
      @app.call( env )
    end
  end
end
