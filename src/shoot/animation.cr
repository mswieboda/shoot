module Shoot
  class Animation
    getter width
    getter height
    getter frame
    getter fps_factor
    getter? loops
    getter sprites
    getter? paused

    def initialize(fps_factor = 60, loops = true)
      @width = 0
      @height = 0
      @frame = 0
      @sprites = [] of SF::Sprite

      @fps_factor = fps_factor
      @loops = loops
      @paused = false
    end

    def add(filename : String, x, y, width, height)
      texture = SF::Texture.from_file(filename, SF::IntRect.new(x, y, width, height))
      sprite = SF::Sprite.new(texture)
      sprite.origin = texture.size / 2.0

      sprites << sprite

      @height = height if height > @height
      @width = width if width > width
    end

    def restart
      @paused = false
      @frame = 0
    end

    def done?
      frame >= total_frames
    end

    def pause
      @paused = true
    end

    def display_frame
      (frame / fps_factor).to_i
    end

    def total_frames
      (sprites.size * fps_factor).to_i - 1
    end

    def update(_frame_time)
      return if paused?

      restart if loops? && done?

      @frame += 1 if frame < total_frames
    end

    def draw(window, x, y, flip_horizontal = false, flip_vertical = false)
      if sprite = sprites[display_frame]
        sprite.position = SF.vector2(x, y)

        window.draw(sprite)
      else
        raise "> Animation#draw !sprite"
      end
    end
  end
end