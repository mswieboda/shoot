require "../keys"
require "./base"
require "./start"
require "./main"

module Shoot::Scene
  class Manager
    getter keys

    property scene : Base
    property start
    property main

    getter? exit

    def initialize(screen_width, screen_height)
      @keys = Keys.new

      @start = Start.new(screen_width, screen_height)
      @main = Main.new(screen_width, screen_height)

      @scene = start
      @exit = false
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

    def switch(nextScene : Base)
      scene.reset

      @scene = nextScene

      scene.init
    end

    def event(event)
      case event
      when SF::Event::KeyPressed
        keys.pressed(event.code)
      when SF::Event::KeyReleased
        keys.released(event.code)
      end
    end

    def update(frame_time)
      check_scenes
      scene.update(frame_time, keys)
      keys.reset
    end

    def draw(window : SF::RenderWindow)
      scene.draw(window)
    end
  end
end
