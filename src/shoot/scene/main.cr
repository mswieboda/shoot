require "../ship"
require "../hud"
require "../keys"

module Shoot::Scene
  class Main < Base
    getter ship
    getter hud

    def initialize(screen_width, screen_height)
      super(screen_width, screen_width, :main)

      @ship = Ship.new(screen_height: screen_height)
      @hud = HUD.new(ship: ship, screen_width: screen_width, screen_height: screen_height)
    end

    def update(frame_time, keys : Keys)
      if keys.just_pressed?(Keys::Escape)
        @exit = true
        return
      end

      ship.update(frame_time, keys)
      hud.update(frame_time)
    end

    def draw(window)
      ship.draw(window)
      hud.draw(window)
    end
  end
end
