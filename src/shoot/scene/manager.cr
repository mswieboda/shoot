require "./base"
require "./start"
require "./main"

module Shoot::Scene
  class Manager
    property scene : Base
    property start
    property main

    def initialize(screen_width, screen_height)
      @start = Start.new(screen_width, screen_height)
      @main = Main.new(screen_width, screen_height)

      @scene = main
    end

    def update(frame_time)
      scene.update(frame_time)
    end

    def draw(window : SF::RenderWindow)
      scene.draw(window)
    end
  end
end
