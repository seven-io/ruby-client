require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

desc 'Generate CHANGELOG.md from git history'
task :changelog do
  require_relative './scripts/generate_changelog'
  Scripts::GenerateChangelog.run
end

task default: :spec