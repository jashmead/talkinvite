# rcov copied over from RSpec book, but got error on spec_files line
require 'rake'
require 'rspec/core/rake_task'

namespace :spec do
  desc "Run specs with RCov"
  RSpec::Core::RakeTask.new('rcov') do |t|
    t.spec_files = FileList['spec/**/*_spec.rb']
    t.rcov = true
    t.rcov_opts = ['--exclude', '\/Library\/Ruby']
  end
end
