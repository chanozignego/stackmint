require 'stackmint/capistrano/base'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  namespace :rvm do
    # default_run_options[:shell] = '/bin/bash --login'

    desc "Install the latest ruby patch with rvm"
    task :install, roles: :app do
      # run_as_user "root", "gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3"
      run_as_user "root", "gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB"
      run_as_user "root", "curl -sSL https://get.rvm.io | bash -s stable"
    end

    task :install_ruby, roles: :app do
      run_as_user "root", "rvm install --default 2.5.1"
    end

    task :add_user_to_rvm, roles: :app do
      run "#{sudo} addgroup #{user} rvm"
    end

    task :add_app_to_rvm, roles: :app do
      run "#{sudo} addgroup #{application} rvm"
    end
  end
end
