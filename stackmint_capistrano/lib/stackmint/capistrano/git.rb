require 'stackmint/capistrano/base'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)


configuration.load do

  def add_domain_to_known_hosts(hostname)
    ip_address = "`dig +short A #{hostname}`"
    run_as_user user, "ssh-keygen -R #{hostname}"
    run_as_user user, "ssh-keygen -R #{ip_address}"
    run_as_user user, "ssh-keygen -R #{hostname},#{ip_address}"
    run_as_user user, "ssh-keyscan -H #{hostname},#{ip_address} >> ~/.ssh/known_hosts"
    run_as_user user, "ssh-keyscan -H #{ip_address} >> ~/.ssh/known_hosts"
    run_as_user user, "ssh-keyscan -H #{hostname} >> ~/.ssh/known_hosts"
  end

  namespace :git_config do
    desc "Add host configuration for the application"
    task :setup, roles: :app do
      run_as_user user, "mkdir -p ~/.ssh"
      run_as_user user, "touch ~/.ssh/known_hosts"
      add_domain_to_known_hosts("github.com")
      add_domain_to_known_hosts("gitlab.redmintlabs.com")
    end
  end
end
