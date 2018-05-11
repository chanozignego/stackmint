require 'stackmint/capistrano/common'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do
  namespace :gulp do
    desc "Start gulp apps"
    task :restart do
      gulp_apps.each do |platform|
        run "cd #{platform} && forever start node_modules/gulp/bin/gulp.js #{environment}"
      end
    end
  end
end