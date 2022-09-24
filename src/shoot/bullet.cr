module Shoot
  class Bullet
    property? remove
    property sprite

    SPEED = 10

    def initialize(x, y)
      texture = SF::Texture.from_file("./assets/ship.png")

      @sprite = SF::Sprite.new(texture)
      @sprite.origin = texture.size / 2.0
      @sprite.scale = SF.vector2(0.25, 0.25)
      @sprite.position = SF.vector2(x, y)
    end

    def update(frame_time)
      sprite.move(0, -SPEED)

      if sprite.position.y <= 0
        @remove = true
      end
    end

    def draw(window : SF::RenderWindow)
      window.draw(sprite)
    end
  end
end
