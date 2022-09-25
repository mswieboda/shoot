require "../keys"

module Shoot::Scene
  abstract class Base
    getter name
    getter screen_width : Int32
    getter screen_height : Int32
    property? exit

    def initialize(screen_width, screen_height, name = :base)
      @screen_width = screen_width
      @screen_height = screen_height
      @name = name
      @exit = false
    end

    def init
    end

    def reset
      @exit = false
    end

    abstract def update(frame_time, keys : Keys)

    abstract def draw(window : SF::RenderWindow)
  end
end
