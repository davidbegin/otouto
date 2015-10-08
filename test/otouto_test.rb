require 'test_helper'

class TestCreatingNewOtoutoApp < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Otouto::VERSION
  end

  def setup
    Otouto.base_dir = "tmp"
    FileUtils.rmdir "tmp"
    @app_name = "new_app"
  end

  def teardown
    FileUtils.rm_r Dir.glob('tmp/*')
    Otouto.reset_base_dir!
  end

  def test_it_creates_a_config_dir
    refute File.exists?("tmp/#{@app_name}/config")
    cli = Otouto::CLI.new(@app_name)
    cli.create_new_app
    assert File.exists?("tmp/#{@app_name}/config")
  end
end
