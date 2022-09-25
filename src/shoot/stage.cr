require "./scene/start"
require "./scene/main"

module Shoot
  class Stage < GSF::Stage
    property start
    property main

    def initialize
      super

      @start = Scene::Start.new
      @main = Scene::Main.new

      @scene = start
    end

    def check_scenes
      case scene.name
      when :start
        @exit = true if scene.exit?
        switch(main) if start.start?
      when :main
        switch(start) if scene.exit?
      end
    end
  end
end
