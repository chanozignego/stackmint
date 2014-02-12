require 'stackmint/capistrano/base'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  namespace :bundler do
    desc "Install the latest ruby patch with rvm"
    task :install, roles: :app do
      run "#{sudo} gem install bundler"
    end
  end
end
