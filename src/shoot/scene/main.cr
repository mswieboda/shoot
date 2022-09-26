require "../ship"
require "../hud"

module Shoot::Scene
  class Main < GSF::Scene
    getter ship
    getter hud

    def initialize
      super(:main)

      @ship = Ship.new(x: 128, y: 128)
      @hud = HUD.new(ship: ship)
    end

    def update(frame_time, keys : Keys, mouse : Mouse)
      if keys.just_pressed?(Keys::Escape)
        @exit = true
        return
      end

      ship.update(frame_time, keys)
      hud.update(frame_time, mouse)
    end

    def draw(window)
      ship.draw(window)
      hud.draw(window)
    end
  end
end
