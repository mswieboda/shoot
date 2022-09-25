require "../ship"
require "../hud"

module Shoot::Scene
  class Main < GSF::Scene
    getter ship
    getter hud

    def initialize
      super(:main)

      @ship = Ship.new
      @hud = HUD.new(ship: ship)
    end

    def update(frame_time, keys : GSF::Keys)
      if keys.just_pressed?(GSF::Keys::Escape)
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
