guard 'coffeescript', output: 'spec' do
  watch %r<^spec/(.*)\.coffee>
end
guard 'coffeescript', output: 'src/javascripts' do
  watch %r<^src/coffeescripts/(.*)\.coffee>
end

guard 'sprockets',
  destination: "js",
  minify:      false,
  asset_paths: %w[
    src/coffeescripts
    src/coffeescripts/models
    src/coffeescripts/views
    src/libs
  ] do
  watch %r<^src/coffeescripts/.+\.js\.coffee>
  watch "src/coffeescripts/dashboard.js.coffee"
end

guard 'bundler' do
  watch 'Gemfile'
end

guard :shell do
  watch %r<spec/.+\.js> do |m|
    `open spec_runner.html`
  end
end
