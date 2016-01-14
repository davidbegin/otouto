# require "otouto/version"
# require "otouto/app"
# require "otouto/cli"
# require "otouto/title"
require_relative "otouto/version"
require_relative "otouto/app"
require_relative "otouto/cli"
require_relative "otouto/title"
require "fileutils"
require "downup"

module Otouto
  class << self
    # base_dir is the directory that a new project will generated in.
    # it defaults to the current directory
    attr_accessor :base_dir

    # sets the base directory back to the current directory
    def reset_base_dir!
      @base_dir = ""
    end
  end
end
