require "yaml"
require "ostruct"

module Otouto
  class App
    def start
      hostname  = request_hostname
      route     = request_route(hostname)
      route     = request_and_add_data_to_route(hostname, route)

      p curl_stmt = "curl " + headers + hostname + route + parse_if_html
      sleep 1
      p system(curl_stmt)
    end

    private

    def request_and_add_data_to_route(hostname, route)
      route_letter, route_hash = routes(hostname).find { |route_letter, route_hash|
        route_hash.fetch("url") == route
      }

      @route_obj = OpenStruct.new(route_hash)
      data_hash = if @route_obj.data.empty?
                    {}
                  else
                    @route_obj.data.each_with_object({}) do |data_needed, data_hash|
                      puts
                      print data_needed.to_s + " > "
                      data_hash[data_needed] = gets.chomp
                    end
                  end

      data_hash.each_pair { |param, value| route.sub!(":#{param}", value) }
      route
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
      @route_obj.content_type == "HTML" ?  " | html2text" : ""
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

    def headers
      " -A Mozilla "
    end

  end
end
