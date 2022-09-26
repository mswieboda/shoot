require "./laser"

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

    def initialize(x = 0, y = 0)
      # sprite size
      size = 128
      @x = x
      @y = y
      @animations = GSF::Animations.new
      @lasers = [] of Laser
      @fire_timer = GSF::Timer.new(FireDuration)
      @fire_sound = SF::Sound.new
      @fire_sound.buffer = FireSound

      # init animations
      fps = 60

      # idle
      idle = GSF::Animation.new((fps / 3).to_i, loops: false)
      idle.add(Sheet, 0, 0, size, size)

      # fire animation
      fire_frames = 3
      fire = GSF::Animation.new((fps / 25).to_i, loops: false)

      fire_frames.times do |i|
        fire.add(Sheet, i * size, 0, size, size)
      end

      animations.add(:idle, idle)
      animations.add(:fire, fire)
      animations.play(:idle)
    end

    def update(frame_time, keys : Keys)
      animations.update(frame_time)

      dy = 0

      if keys.pressed?(Keys::Up)
        dy -= Speed
      elsif keys.pressed?(Keys::Down)
        dy += Speed
      end

      if y + dy > 0 && y + dy < GSF::Screen.height
        @y += dy
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
