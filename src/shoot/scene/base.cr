module Shoot::Scene
  abstract class Base
    getter screen_width : Int32
    getter screen_height : Int32

    def initialize(screen_width, screen_height)
      @screen_width = screen_width
      @screen_height = screen_height
    end

    abstract def update(frame_time)

    abstract def draw(window : SF::RenderWindow)
  end
end
