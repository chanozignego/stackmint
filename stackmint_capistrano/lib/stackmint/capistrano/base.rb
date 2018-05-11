require 'stackmint/capistrano/common'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  namespace :host do
    desc "Install everything onto the server"
    task :install do
      run "#{sudo} apt-get -y update"
      run "#{sudo} apt-get -y install python-software-properties git-core vim curl wget"
    end

    desc "Restart server"
    task :restart do
      run "#{sudo} reboot"
    end

    desc "Clean all log files"
    task :clean_logs do
      log_files.each do |logfile|
        run "cd /home/#{application}/app/log && truncate --size 0 #{logfile}"
      end
    end
  end
end
