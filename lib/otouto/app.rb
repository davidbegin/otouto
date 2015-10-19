require "yaml"
require "ostruct"

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

      route_letter, route_hash = routes(hostname).find { |route_letter, route_hash|
        route_hash.fetch("url") == route
      }

      route_obj = OpenStruct.new(route_hash)

      curl_stmt = "curl -A Mozilla " + hostname + route + parse_if_html(route_obj)
      p system(curl_stmt)
    end

    private

    def parse_if_html(route_obj)
      route_obj.content_type == "HTML" ?  " | html2text" : ""
    end

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
