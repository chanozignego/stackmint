require 'stackmint/capistrano/base'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  namespace :dev_lib do
    task :install do
      run "#{sudo} apt-get -y install libxslt-dev libxml2-dev imagemagick libsqlite3-dev freetds"
    end
  end
end
