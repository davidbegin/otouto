require "otouto/version"
require "fileutils"

module Otouto
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
      FileUtils.mkdir("#{self.class.base_dir}")
      FileUtils.mkdir("#{self.class.base_dir}/#{app_name}")
      FileUtils.mkdir("#{self.class.base_dir}/#{app_name}/config")
      FileUtils.touch("#{self.class.base_dir}/#{app_name}/config/hostnames.yml")
    end

    def coming_soon
      puts "\n\n"
      (41..48).each do |color|
        print "\t\e[1m\e[#{color.to_s}mComing soon\e[0m"
        print "\t\e[1m\e[#{(color - 10).to_s}mComing soon\e[0m"
        puts "\n\n"
      end
    end

    def title
      "\e[1m\e[35mOTOUTO\e[0m"
    end

    def otouto
      "\e[1m\e[33m(╯°□°)╯︵ \e[5m\e[36m┻━┻\e[0m"
    end

    class << self
      def base_dir
        "tmp"
      end
    end
  end
end
