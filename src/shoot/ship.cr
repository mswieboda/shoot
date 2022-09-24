require "./bullet"

module Shoot
  class Ship
    property sprite
    property bullets

    SPEED = 10

    def initialize(screen_height)
      texture = SF::Texture.from_file("./assets/ship.png")

      @sprite = SF::Sprite.new(texture)
      @sprite.origin = texture.size / 2.0
      @sprite.scale = SF.vector2(1, 1)
      @sprite.position = SF.vector2(250, screen_height - texture.size.y / 2.0 - texture.size.y)

      @bullets = [] of Bullet
    end

    def update(frame_time)
      if SF::Keyboard.key_pressed?(SF::Keyboard::Left)
        sprite.move(-SPEED, 0)
      elsif SF::Keyboard.key_pressed?(SF::Keyboard::Right)
        sprite.move(SPEED, 0)
      end

      if SF::Keyboard.key_pressed?(SF::Keyboard::X)
        bullets << Bullet.new(sprite.position.x, sprite.position.y)
      end

      bullets.each(&.update(frame_time))
      bullets.select(&.remove?).each do |bullet|
        bullets.delete(bullet)
      end
    end

    def draw(window : SF::RenderWindow)
      bullets.each(&.draw(window))

      window.draw(sprite)
    end
  end
end
