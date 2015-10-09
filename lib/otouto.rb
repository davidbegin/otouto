require "otouto/version"
require "fileutils"

module Otouto
  class << self
    # base_dir is directory that a new project will generated in
    # it defaults to the current directory
    attr_accessor :base_dir

    # sets the base director back to the current_directory
    def reset_base_dir!
      @base_dir = ""
    end
  end

  class CLI

    def initialize(app_name)
      @app_name = app_name
    end

    def create_new_app
      puts "\n\n\t#{otouto}  #{title}\n"
      create_config_dir
    end

    private

    attr_reader :app_name

    def create_config_dir
      FileUtils.mkdir_p("#{Otouto.base_dir}/#{app_name}/config")
      FileUtils.touch("#{Otouto.base_dir}/#{app_name}/config/hostnames.yml")
    end

    def title
      "\e[1m\e[35mOTOUTO\e[0m"
    end

    def otouto
      "\e[1m\e[33m(╯°□°)╯︵ \e[5m\e[36m┻━┻\e[0m"
    end
  end
end
