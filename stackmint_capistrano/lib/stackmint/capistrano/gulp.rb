require 'stackmint/capistrano/common'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  namespace :gulp do
    desc "Start gulp apps"
    task :restart do
      gulp_apps.each do |platform|
        gulp_task == "production" ? "prod" : "staging"
        run "cd #{platform} && forever start node_modules/gulp/bin/gulp.js #{gulp_task}"
      end
    end

    desc "Deploy gulp apps"
    task :deploy do
      run "cd #{platform} && git stash"
      run "cd #{platform} && git pull origin #{branch}"
      gulp_task = (environment == "production") ? "prod" : "staging"
      begin
        run "cd #{platform} && gulp #{gulp_task}"
      rescue e
        puts "Deploy #{platform} [OK]"
      end
    end
  end
end