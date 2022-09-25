require "./laser"
require "./timer"
require "./animations"
require "./animation"

module Shoot
  class Ship
    getter x : Int32
    getter y : Int32
    getter animations
    getter lasers
    getter fire_timer
    getter fire_sound

    Speed = 15
    FireDuration = 100.milliseconds
    Sheet = "./assets/ship.png"
    FireSound = SF::SoundBuffer.from_file("./assets/laser.wav")

    def initialize(screen_height)
      # sprite size
      size = 128
      @x = 250
      @y = (screen_height - size / 2.0 - size).to_i
      @animations = Animations.new
      @lasers = [] of Laser
      @fire_timer = Timer.new(FireDuration)
      @fire_sound = SF::Sound.new
      @fire_sound.buffer = FireSound

      # init animations
      fps = 60

      # idle
      idle = Animation.new((fps / 3).to_i, loops: false)
      idle.add(Sheet, 0, 0, size, size)

      # fire animation
      fire_frames = 3
      fire = Animation.new((fps / 25).to_i, loops: false)

      fire_frames.times do |i|
        fire.add(Sheet, i * size, 0, size, size)
      end

      animations.add(:idle, idle)
      animations.add(:fire, fire)
      animations.play(:idle)
    end

    def update(frame_time, keys)
      animations.update(frame_time)

      if keys.pressed?(Keys::Left)
        @x -= Speed
      elsif keys.pressed?(Keys::Right)
        @x += Speed
      end

      fire if keys.pressed?(Keys::X)

      animations.play(:idle) if animations.name == :fire && animations.done?

      lasers.each(&.update(frame_time))
      lasers.select(&.remove?).each do |laser|
        lasers.delete(laser)
      end
    end

    def draw(window : SF::RenderWindow)
      lasers.each(&.draw(window))

      animations.draw(window, x, y)
    end

    def fire
      return if fire_timer.started? && !fire_timer.done?

      animations.play(:fire)
      @fire_sound.play
      lasers << Laser.new(x, y)

      fire_timer.restart
    end
  end
end
