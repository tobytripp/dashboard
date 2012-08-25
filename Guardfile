guard 'coffeescript', output: 'spec' do
  watch %r<^spec/(.*)\.coffee>
end
guard 'coffeescript', output: 'src/javascripts' do
  watch %r<^src/coffeescripts/(.*)\.coffee>
end

guard 'livereload' do
  watch %r<^spec/javascripts/.+\.js$>
  watch %r<^src/javascripts/.+\.js$>
end

guard 'sprockets',
  destination: "build",
  minify:      false,
  asset_paths: ['src/coffeescripts', 'js/libs'] do
  watch %r<^src/coffeescripts/.+\.js\.coffee>
#  watch 'src/coffeescripts/dashboard.js.coffee'
end

guard 'bundler' do
  watch 'Gemfile'
end

guard :shell do
  watch %r<spec/.+\.js> do |m|
    `open spec_runner.html`
  end
end
