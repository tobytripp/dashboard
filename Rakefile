require 'rubygems'
require 'bundler'
require 'pp'

Bundler.require
require 'rake/sprocketstask'

$LOAD_PATH.unshift "src/ruby"
require "dashboard_environment"

Rake::SprocketsTask.new do |t|
  t.environment = Dashboard.environment
  t.output      = Dashboard::BUILD_DIR
  t.assets      = %w( dashboard.js plugins.js )
end

file "dashboard.html" => ["dashboard.html.erb", :assets] do |t|
  require 'erb'
  src = t.prerequisites.first
  template = ERB.new File.read( src )

  Dashboard::LOGGER.info "Writing #{t.name}"
  File.open( t.name, 'w' ) { |f| f.write template.result( binding ) }
end

task default: "dashboard.html"

begin
  require 'jasmine'
  load 'jasmine/tasks/jasmine.rake'
rescue LoadError
  task :jasmine do
    abort "Jasmine is not available. In order to run jasmine, you must: (sudo) gem install jasmine"
  end
end
