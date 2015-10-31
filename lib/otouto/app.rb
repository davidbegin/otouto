require "yaml"
require "ostruct"

module Otouto
  class App
    def start
      hostname  = request_hostname
      route     = request_route(hostname)
      route     = request_and_add_data_to_route(hostname, route)

      p curl_stmt = "curl " + hostname + route + headers(hostname) + parse_if_html
      sleep 1
      p system(curl_stmt)
    end

    private

    def request_and_add_data_to_route(hostname, route)
      _, route_hash = routes(hostname).find { |_, route_hash|
        route_hash["url"] == route
      }

      @route_obj = OpenStruct.new(route_hash)
      data_hash = data_collector

      data_hash.each_pair { |param, value| route.sub!(":#{param}", value) }
      route
    end

    def data_collector
      return {} if @route_obj.data.empty?

      @route_obj.data.each_with_object({}) do |data_needed, data_hash|
        puts
        print data_needed.to_s + " > "
        data_hash[data_needed] = gets.chomp
      end
    end

    def request_hostname
      Downup::Base.new(
        options: hostnames,
        header_proc: Title.method(:print)
      ).prompt
    end

    def request_route(hostname)
      Downup::Base.new(
        options: route_option_generator(hostname),
        header_proc: Title.method(:print)
      ).prompt
    end

    def parse_if_html
      @route_obj.content_type == "HTML" ? " | html2text" : ""
    end

    def route_option_generator(hostname)
      routes(hostname).keys.map.with_object({}) do |elem, options|
        options[elem] = route_info.fetch(elem).fetch("url")
      end
    end

    def routes(hostname)
      @routes ||= YAML.load_file("config/routes.yml").fetch(hostname)
    end

    def hostnames
      @hostnames ||= hostname_configuration.keys
    end

    def hostname_configuration
      @hostname_configuration ||= YAML.load_file("config/hostnames.yml")
    end

    def headers(hostname)
      user_headers = hostname_configuration.
        fetch(hostname).
        fetch("headers") { [] }.map do |key, value|
        "-H #{key}: #{value}"
      end.join(" ")

      " -A Mozilla " + user_headers + " "
    end

  end
end
