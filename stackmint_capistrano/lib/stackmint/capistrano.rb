require 'stackmint/capistrano/version'
require 'stackmint/capistrano/common'
require 'erb'

module Stackmint
  module Capistrano
    # Parametrizes the creation of a capfile file
    # Allows the following parameters
    #    database: :mysql | :postgres
    #    deploy:   :recap | :default
    #    template: Template path, default is tmpls/Capfile.rb.erb
    # The rest of the file will be bootstrapped and ready to be configured
    class CapfileTemplater
       def initialize opts = {}
         @database = opts[:database] || :postgres
         @deploy   = opts[:deploy]   || :recap
         @template = opts[:template] || "Capfile.rb.erb"
       end

       def render!
         render_template(@template)
       end

       def save filename = "Capfile"
         File.open("Capfile", "w") do |f|
            f.write render!
         end
       end
    end
  end
end
