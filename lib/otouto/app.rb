require "yaml"

module Otouto
  class App
    def start
      Downup::Base.new(
        options: hostnames,
        header_proc: Title.method(:print)
      ).prompt
    end

    private

    def hostnames
      @hostnames ||= YAML.load_file("config/hostnames.yml")
    end

  end
end
