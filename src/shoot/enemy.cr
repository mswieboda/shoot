require "./laser"

module Shoot
  class Enemy
    getter x : Int32
    getter y : Int32
    getter animations
    property? remove
    getter health
    getter hit_sound

    Sheet = "./assets/ship.png"
    HitSound = SF::SoundBuffer.from_file("./assets/hit.wav")

    delegate global_bounds, to: animations

    def initialize(x = 0, y = 0)
      # sprite size
      size = 128
      @x = x
      @y = y
      @health = 100
      @hit_sound = SF::Sound.new(HitSound)

      # init animations
      fps = 60

      # idle
      idle = GSF::Animation.new((fps / 3).to_i, loops: false)
      idle.add(Sheet, 0, 0, size, size, color: SF::Color.new(255, 80, 80))

      @animations = GSF::Animations.new(:idle, idle, flip_horizontal: true)
    end

    def update(_frame_time)
    end

    def draw(window : SF::RenderWindow)
      animations.draw(window, x, y)
    end

    def hit(laser : Laser)
      @health -= laser.damage

      laser.remove = true

      hit_sound.play

      if @health <= 0
        @health = 0
        @remove = true
      end
    end
  end
end
