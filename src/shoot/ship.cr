module Shoot
  class Ship
    property :sprite

    SPEED = 10

    def initialize
      texture = SF::Texture.from_file("./assets/ship.png")

      @sprite = SF::Sprite.new(texture)
      @sprite.origin = texture.size / 2.0
      @sprite.scale = SF.vector2(1, 1)
      @sprite.position = SF.vector2(250, 300)
    end

    def update(frame_time)
      if SF::Keyboard.key_pressed?(SF::Keyboard::Left)
        sprite.move(-SPEED, 0)
      elsif SF::Keyboard.key_pressed?(SF::Keyboard::Right)
        sprite.move(SPEED, 0)
      end
    end

    def draw(window : SF::RenderWindow)
      window.draw(sprite)
    end
  end
end
