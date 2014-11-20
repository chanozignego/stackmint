require 'stackmint/capistrano/base'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  namespace :rvm do
    # default_run_options[:shell] = '/bin/bash --login'

    desc "Install the latest ruby patch with rvm"
    task :install, roles: :app do
      run_as_user "root", "curl -sSL https://rvm.io/mpapis.asc | gpg --import -"
      run_as_user "root", "curl -sSL https://get.rvm.io | bash -s stable"
    end

    task :install_ruby, roles: :app do
      run_as_user "root", "rvm install --default 2.0.0"
    end

    task :add_user_to_rvm, roles: :app do
      run "#{sudo} addgroup #{user} rvm"
    end

    task :add_app_to_rvm, roles: :app do
      run "#{sudo} addgroup #{application} rvm"
    end
  end
end
