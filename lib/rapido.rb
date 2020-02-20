require 'rapido/version'
require 'rapido/controller'
require 'rapido/api_controller'

module Rapido
  class << self
    attr_writer :configuration
  end

  class Configuration
    def initialize
    end
  end

  class Engine < ::Rails::Engine
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
