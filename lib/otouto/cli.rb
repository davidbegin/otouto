module Otouto
  class CLI
    def initialize(app_name)
      @app_name = app_name
    end

    def create_new_app
      Title.print unless ENV["TEST_MODE"] == "true"

      create_config_dir
      create_sample_hostnames_file
      create_sample_routes_file
      create_bin_and_oto_excutable
      create_gemfile
    end

    private

    attr_reader :app_name

    def create_config_dir
      FileUtils.mkdir_p("#{config_path}")
    end

    def create_sample_routes_file
      FileUtils.cp(
        "config/routes.yml",
        "#{Otouto.base_dir}/#{app_name}/config/routes.yml"
      )
    end

    def create_sample_hostnames_file
      FileUtils.cp(
        "config/hostnames.yml",
        "#{Otouto.base_dir}/#{app_name}/config/hostnames.yml"
      )
    end

    def create_gemfile
      FileUtils.cp("config/Gemfile", "#{Otouto.base_dir}/#{app_name}/Gemfile")
    end

    def create_bin_and_oto_excutable
      create_bin_dir
      FileUtils.cp("config/oto", "#{bin_path}/oto")
      FileUtils.chmod("+x", "#{bin_path}/oto")
    end

    def create_bin_dir
      FileUtils.mkdir_p("#{bin_path}")
    end

    def bin_path
      "#{Otouto.base_dir}/#{app_name}/bin"
    end

    def config_path
      "#{Otouto.base_dir}/#{app_name}/config"
    end
  end
end
