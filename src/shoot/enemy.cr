require "./laser"

module Shoot
  class Enemy
    getter x : Int32
    getter y : Int32
    getter animations
    property? remove
    getter health
    getter hit_sound

    MaxHealth = 100
    Size = 128 # sprite size for sprite sheet
    Color = SF::Color.new(255, 80, 80)
    Sheet = "./assets/ship.png"
    HitSound = SF::SoundBuffer.from_file("./assets/hit.wav")

    delegate global_bounds, to: animations

    def initialize(x = 0, y = 0)
      @x = x
      @y = y
      @health = MaxHealth
      @hit_sound = SF::Sound.new(HitSound)

      # init animations
      fps = 60

      # idle
      idle = GSF::Animation.new((fps / 3).to_i, loops: false)
      idle.add(Sheet, 0, 0, Size, Size, color: Color)

      @animations = GSF::Animations.new(:idle, idle, flip_horizontal: true)
    end

    def update(_frame_time)
    end

    def draw(window : SF::RenderWindow)
      animations.draw(window, x, y, color: health_color)
      draw_health(window) if health_percent < 1
    end

    def draw_health(window)
      box = SF::RectangleShape.new({health_percent * Size, 3})
      box.position = {(x - Size / 2), (y - Size / 2)}
      box.fill_color = health_color

      window.draw(box)
    end

    def health_percent
      health / MaxHealth
    end

    def health_color
      if health > 75
        SF::Color::Green
      elsif health > 50
        SF::Color::Yellow
      elsif health > 25
        SF::Color.new(255, 128, 0)
      else
        SF::Color::Red
      end
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
