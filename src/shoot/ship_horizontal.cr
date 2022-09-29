require "./ship_base"

module Shoot
  class ShipHorizontal < ShipBase
    def update_movement(keys : Keys)
      dy = 0

      if keys.pressed?(Keys::Up)
        dy -= Speed
      elsif keys.pressed?(Keys::Down)
        dy += Speed
      end

      if y + dy > 0 && y + dy < GSF::Screen.height
        move(0, dy)
      end
    end
  end
end
