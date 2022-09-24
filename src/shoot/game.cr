require "./game_window"
require "./scene/manager"

module Shoot
  class Game < GameWindow
    getter manager

    def initialize
      super

      @manager = Scene::Manager.new(screen_width: window.size.x, screen_height: window.size.y)
    end

    def update(frame_time)
      manager.update(frame_time)
    end

    def draw(window)
      manager.draw(window)
    end
  end
end
