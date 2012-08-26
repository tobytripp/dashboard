require 'pathname'

module Dashboard
  ROOT = Pathname( File.join File.dirname(__FILE__), "..", ".." )

  LOGGER      = Logger.new( STDOUT )
  BUILD_DIR   = ROOT.join( "js" )
  SOURCE_DIR  = ROOT.join( "src" )

  MAIN_JS     = "dashboard.js"

  def self.environment( compress=false )
    require 'sprockets'
    @env ||= Sprockets::Environment.new( ROOT ) do |env|
      env.logger = LOGGER
      env.js_compressor = Uglifier.new mangle: true if compress

      env.append_path SOURCE_DIR.join( 'coffeescripts' ).to_s
      env.append_path SOURCE_DIR.join( 'coffeescripts/models' ).to_s
      env.append_path SOURCE_DIR.join( 'coffeescripts/views' ).to_s
      env.append_path SOURCE_DIR.join( 'libs' ).to_s
    end
  end

  def self.main_path
    File.join "js", environment[MAIN_JS].digest_path
  end

  def self.plugin_path
    File.join "js", environment['plugins.js'].digest_path
  end
end
