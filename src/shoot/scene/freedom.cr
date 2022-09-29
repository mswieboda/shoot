require "../ship"
require "../hud"
require "../enemy"

module Shoot::Scene
  class Freedom < GSF::Scene
    getter view : GSF::View
    getter ship
    getter hud
    getter enemies

    def initialize(window)
      super(:freedom)

      @ship = Ship.new(x: (0.5 * GSF::Screen.height).to_i, y: 300)
      @hud = HUD.new(ship: ship)
      @enemies = [] of Enemy

      [{0.7, 0.3}, {0.85, 0.1}, {0.9, 0.75}, {0.75, 0.6}, {0.69, 0.69}].each do |pos|
        x = pos[0] * GSF::Screen.width
        y = pos[1] * GSF::Screen.height

        @enemies << Enemy.new(x.to_i, y.to_i)
      end

      @view = GSF::View.from_default(window).dup
    end

    def update(frame_time, keys : Keys, mouse : Mouse, joysticks : Joysticks)
      if keys.just_pressed?(Keys::Escape)
        @exit = true
        return
      end

      ship.update(frame_time, keys)
      view_test(keys)
      enemies.each(&.update(frame_time))

      laser_checks

      hud.update(frame_time, mouse)
    end

    def view_test(keys)
      view.center(ship.x, ship.y)
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
      view.set_current

      ship.draw(window)
      enemies.each(&.draw(window))

      view.set_default_current

      hud.draw(window)
    end
  end
end
