require 'stackmint/capistrano/base'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  namespace :recap do
    desc "Install the latest ruby patch with rvm"
    task :set_env, roles: :app do
      run "#{sudo} touch /home/#{application}/.env"
      run "#{sudo} chown #{user}:#{user} /home/#{application}/.env"
      run "#{sudo} echo PATH=\$PATH:$PATH >> /home/#{application}/.env"
      run "#{sudo} chown #{application}:#{application} /home/#{application}/.env"
    end
  end

  after "bootstrap", "recap:set_env"
end
