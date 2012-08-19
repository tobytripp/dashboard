require 'rubygems'
require 'bundler'
require 'pathname'
require 'logger'
require 'fileutils'

Bundler.require

ROOT        = Pathname( File.dirname( __FILE__ ) )
LOGGER      = Logger.new( STDOUT )
BUNDLES     = %w( all.css all.js )
BUILD_DIR   = ROOT.join( "js" )
SOURCE_DIR  = ROOT.join( "src" )

task :compile => :cleanup do
  sprockets = Sprockets::Environment.new( ROOT ) do |env|
    env.logger = LOGGER
  end

  sprockets.append_path( SOURCE_DIR.join( 'javascripts' ).to_s )
  sprockets.append_path( SOURCE_DIR.join( 'stylesheets' ).to_s )

  BUNDLES.each do |bundle|
    assets = sprockets.find_asset( bundle )
    prefix, basename = assets.pathname.to_s.split( '/' )[-2..-1]
    FileUtils.mkpath BUILD_DIR.join( prefix )

    assets.write_to( BUILD_DIR.join( prefix, basename ) )
    assets.to_a.each do |asset|
      # strip filename.css.foo.bar.css multiple extensions
      realname = asset.pathname.basename.to_s.split( "." )[0..1].join( "." )
      asset.write_to( BUILD_DIR.join( prefix, realname ) )
    end
  end
end

begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end
