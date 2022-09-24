require "./game_window"
require "./ship"
require "./hud"

module Shoot
  class Game < GameWindow
    getter ship
    getter hud

    def initialize
      super

      @ship = Ship.new(screen_height: window.size.y)
      @hud = HUD.new(ship: ship, screen_width: window.size.x, screen_height: window.size.y)
    end

    def update(frame_time)
      ship.update(frame_time)
      hud.update(frame_time)
    end

    def draw(window)
      ship.draw(window)
      hud.draw(window)
    end
  end
end
