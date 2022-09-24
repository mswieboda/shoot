module Shoot::Scene
  class Start < Base
    def initialize(screen_width, screen_height)
      super(screen_width, screen_height)
    end

    def update(frame_time)
    end

    def draw(window : SF::RenderWindow)
    end
  end
end
