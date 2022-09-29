require "./ship_base"
require "./font"

module Shoot
  class HUD
    getter ship : ShipBase
    getter text

    Margin = 10

    TextColor = SF::Color::Green
    TextColorHover = SF::Color::White
    TextColorJustPressed = SF::Color.new(255, 0, 255)
    TextColorPressed = SF::Color.new(128, 128, 128)
    TextColorJustReleased = SF::Color.new(0, 0, 255)

    def initialize(ship)
      @ship = ship
      @text = SF::Text.new("lasers: 0", Font.default, 24)
      @text.fill_color = TextColor
      @text.position = SF.vector2(Margin, Margin)
    end

    def update(frame_time, mouse : Mouse)
      @text.string = "lasers #{ship.lasers.size}"

      text_hover(mouse)
    end

    def text_hover(mouse)
      x = @text.position.x
      y = @text.position.y
      w = @text.global_bounds.width
      h = @text.global_bounds.height
      hover = mouse.x >= x && mouse.x <= x + w && mouse.y >= y && mouse.y <= y + h

      if hover && mouse.pressed?(Mouse::Left)
        @text.fill_color = mouse.just_pressed?(Mouse::Left) ? TextColorJustPressed : TextColorPressed
      else
        @text.fill_color = hover ? TextColorHover : TextColor
      end
    end

    def draw(window : SF::RenderWindow)
      window.draw(text)
    end
  end
end
