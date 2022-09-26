require "../ship"
require "../hud"
require "../enemy"

module Shoot::Scene
  class Main < GSF::Scene
    getter ship
    getter hud
    getter enemies

    def initialize
      super(:main)

      @ship = Ship.new(x: 128, y: 128)
      @hud = HUD.new(ship: ship)
      @enemies = [] of Enemy

      [{0.7, 0.3}, {0.85, 0.1}, {0.9, 0.75}, {0.75, 0.6}, {0.69, 0.69}].each do |pos|
        x = pos[0] * GSF::Screen.width
        y = pos[1] * GSF::Screen.height

        @enemies << Enemy.new(x.to_i, y.to_i)
      end
    end

    def update(frame_time, keys : Keys, mouse : Mouse)
      if keys.just_pressed?(Keys::Escape)
        @exit = true
        return
      end

      ship.update(frame_time, keys)
      enemies.each(&.update(frame_time))

      laser_checks

      hud.update(frame_time, mouse)
    end

    def laser_checks
      ship.lasers.each do |laser|
        enemies.each do |enemy|
          enemy.hit(laser) if enemy.global_bounds.intersects?(laser.global_bounds)
        end
      end

      enemies.select(&.remove?).each do |enemy|
        enemies.delete(enemy)
      end
    end

    def draw(window)
      ship.draw(window)
      enemies.each(&.draw(window))
      hud.draw(window)
    end
  end
end
