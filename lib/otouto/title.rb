module Otouto
  class Title
    class << self
      def print
        puts "\n\n\t#{otouto}  #{title}\n\n"
      end

      private

      def title
        "\e[1m\e[35mOTOUTO\e[0m"
      end

      def otouto
        "\e[1m\e[33m(╯°□°)╯︵ \e[5m\e[36m┻━┻\e[0m"
      end
    end
  end
end
