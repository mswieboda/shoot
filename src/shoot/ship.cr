require "./ship_base"

module Shoot
  class Ship < ShipBase
    def update_movement(keys : Keys)
      dx = 0
      dy = 0

      dy -= Speed if keys.pressed?(Keys::W)
      dx -= Speed if keys.pressed?(Keys::A)
      dy += Speed if keys.pressed?(Keys::S)
      dx += Speed if keys.pressed?(Keys::D)

      move(dx, dy) if dx.abs > 0 || dy.abs > 0 && y + dy > 0 && x + dy > 0
    end
  end
end
