require 'yard'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'


task default: %w(clean test)

desc "Removes all non-essential project files and folders"
task :clean do
  FileUtils.rm_rf 'coverage'
  FileUtils.rm_rf '.yardoc'
  FileUtils.rm_rf 'doc'
end

desc "Runs the project's entire test suite"
RSpec::Core::RakeTask.new(:test) do |spec|
  spec.pattern = FileList['spec/*/*.rb']
end

namespace :test do
  desc "Runs the project's unit tests"
  RSpec::Core::RakeTask.new(:unit) do |spec|
    spec.pattern = FileList['spec/unit/*_spec.rb']
  end

  desc "Runs the project's integration tests"
  RSpec::Core::RakeTask.new(:integration) do |spec|
    spec.pattern = FileList['spec/integration/*_spec.rb']
  end
end

desc "Generates the project's YARD documentation"
YARD::Rake::YardocTask.new do |task|
  task.files = ['lib/**/*.rb']
  task.options = ['-yardopts .yardopts']
end
