require 'stackmint/capistrano/common'

configuration = Capistrano::Configuration.respond_to?(:instance) ?
  Capistrano::Configuration.instance(:must_exist) :
  Capistrano.configuration(:must_exist)

configuration.load do

  # Basic compatibility implementation of SCM class 
  # for integrating with new relic deployments
  class SCM 
    def initialize cont; @cont = cont; end

    def query_revision *args;    `git rev-parse HEAD`.gsub(/\n/, "");   end
    def head *args;              `git rev-parse HEAD`.gsub(/\n/, "");   end
    def previous_revision *args; `git rev-parse HEAD~2`.gsub(/\n/, ""); end
    def current_revision *args;  `git rev-parse HEAD~1`.gsub(/\n/, ""); end
    def next_revision *args;     `git rev-parse HEAD`.gsub(/\n/, "");   end

    def log *args; end
  end

  set :scm, :git
  set :source, SCM.new(self)
  set :current_revision, source.current_revision
  set :previous_revision, source.previous_revision
  set :next_revision, source.next_revision
  set :real_revision, source.next_revision

end
