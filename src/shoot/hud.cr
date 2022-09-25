require "./font"

module Shoot
  class HUD
    getter ship : Ship
    getter text

    Margin = 10

    def initialize(ship)
      @ship = ship
      @text = SF::Text.new("lasers: 0", Font.default, 24)
      @text.fill_color = SF::Color::Green
      @text.position = SF.vector2(Margin, Margin)
    end

    def update(frame_time)
      @text.string = "lasers #{ship.lasers.size}"
    end

    def draw(window : SF::RenderWindow)
      window.draw(text)
    end
  end
end
