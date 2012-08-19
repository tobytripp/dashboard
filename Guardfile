guard 'coffeescript', output: 'src/javascripts' do
  watch %r<^src/coffeescripts/(.*)\.coffee>
end

guard 'coffeescript', output: 'spec' do
  watch %r<^spec/(.*)\.coffee>
end

guard 'livereload' do
  watch %r<^spec/javascripts/.+\.js$>
  watch %r<^src/javascripts/.+\.js$>
end

guard 'sprockets',
  destination: "build",
  minify:      true,
  asset_paths: ['src/javascripts'] do
  watch( %r{^src/javascripts/.+\.js$} ) { |m| "js/dashboard.js" }
end

guard 'bundler' do
  watch 'Gemfile'
end
