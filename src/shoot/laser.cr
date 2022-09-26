module Shoot
  class Laser
    property? remove
    property sprite

    Speed = 30

    def initialize(x, y)
      texture = SF::Texture.from_file("./assets/laser.png")

      @sprite = SF::Sprite.new(texture)
      @sprite.origin = texture.size / 2.0
      @sprite.scale = SF.vector2(1, 1)
      @sprite.position = SF.vector2(x, y)
    end

    def update(frame_time)
      sprite.move(Speed, 0)

      if sprite.position.x > GSF::Screen.width + sprite.global_bounds.width
        @remove = true
      end
    end

    def draw(window : SF::RenderWindow)
      window.draw(sprite)
    end
  end
end
