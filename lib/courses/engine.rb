module Courses
  class Engine < ::Rails::Engine
    isolate_namespace Courses

    require 'responders'
    require 'font-awesome-rails'

    config.generators do |g|
      g.scaffold_controller :responders_controller
    end
  end
end
