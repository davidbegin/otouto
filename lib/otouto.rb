require "otouto/version"

module Otouto
  class CLI
    def create_new_app
      puts "\n\n\t#{otouto}  #{title}\n"
      coming_soon
    end

    def coming_soon
      puts "\n\n"
      (41..48).each do |color|
        print coming_soon_template(color.to_s)
        print coming_soon_template((color - 10).to_s)
        puts "\n\n"
      end
    end

    def coming_soon_template(color)
       "\t\e[1m\e[#{color}mComing soon\e[0m"
    end

    def title
      "\e[1m\e[35mOTOUTO\e[0m"
    end

    def otouto
      "\e[1m\e[33m(╯°□°)╯︵ \e[5m\e[36m┻━┻\e[0m"
    end
  end
end
