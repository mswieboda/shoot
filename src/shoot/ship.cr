require "./laser"
require "./timer"

module Shoot
  class Ship
    property sprite
    property lasers
    property fire_timer
    property fire_sound

    Speed = 15
    FireDuration = 100.milliseconds
    Texture = SF::Texture.from_file("./assets/ship.png")
    FireSound = SF::SoundBuffer.from_file("./assets/laser.wav")

    def initialize(screen_height)
      @sprite = SF::Sprite.new(Texture)
      @sprite.origin = Texture.size / 2.0
      @sprite.scale = SF.vector2(1, 1)
      @sprite.position = SF.vector2(250, screen_height - Texture.size.y / 2.0 - Texture.size.y)

      @lasers = [] of Laser

      @fire_timer = Timer.new(FireDuration)
      @fire_sound = SF::Sound.new
      @fire_sound.buffer = FireSound
    end

    def update(frame_time)
      if SF::Keyboard.key_pressed?(SF::Keyboard::Left)
        sprite.move(-Speed, 0)
      elsif SF::Keyboard.key_pressed?(SF::Keyboard::Right)
        sprite.move(Speed, 0)
      end

      fire if SF::Keyboard.key_pressed?(SF::Keyboard::X)

      lasers.each(&.update(frame_time))
      lasers.select(&.remove?).each do |laser|
        lasers.delete(laser)
      end
    end

    def draw(window : SF::RenderWindow)
      lasers.each(&.draw(window))

      window.draw(sprite)
    end

    def fire
      return if fire_timer.started? && !fire_timer.done?

      @fire_sound.play
      lasers << Laser.new(sprite.position.x, sprite.position.y)

      fire_timer.restart
    end
  end
end
