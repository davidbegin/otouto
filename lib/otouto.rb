require "otouto/version"
require "otouto/app"
require "otouto/cli"
require "otouto/test"
require "fileutils"
require "downup"

module Otouto
  class << self
    # base_dir is directory that a new project will generated in
    # it defaults to the current directory
    attr_accessor :base_dir

    # sets the base director back to the current_directory
    def reset_base_dir!
      @base_dir = ""
    end
  end
end
