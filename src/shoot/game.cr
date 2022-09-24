require "./game_window"
require "./ship"

module Shoot
  class Game < GameWindow
    getter ship

    def initialize
      super

      @ship = Ship.new
    end

    def update(frame_time)
      ship.update(frame_time)
    end

    def draw(window)
      ship.draw(window)
    end
  end
end
