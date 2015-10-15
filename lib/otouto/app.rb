require "yaml"

module Otouto
  class App
    def start
      hostname = Downup::Base.new(
        options: hostnames,
        header_proc: Title.method(:print)
      ).prompt

      route = Downup::Base.new(
        options: route_option_generator(hostname),
        header_proc: Title.method(:print)
      ).prompt

      puts hostname + route
    end

    private

    def route_option_generator(hostname)
      route_info = routes(hostname)
      route_info.keys.map.with_object({}) do |elem, options|
        options[elem] = route_info.fetch(elem).fetch("url")
      end
    end

    def routes(hostname)
      @routes ||= YAML.load_file("config/routes.yml").fetch(hostname)
    end

    def hostnames
      @hostnames ||= YAML.load_file("config/hostnames.yml")
    end

  end
end
