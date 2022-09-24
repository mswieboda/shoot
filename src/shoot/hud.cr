module Shoot
  class HUD
    getter ship : Ship
    getter screen_width : Int32
    getter screen_height : Int32
    getter text

    Font = SF::Font.from_file("./assets/PressStart2P.ttf")
    Margin = 10

    def initialize(ship, screen_width, screen_height)
      @ship = ship
      @screen_width = screen_width
      @screen_height = screen_height

      @text = SF::Text.new("lasers: 0", Font, 24)
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
