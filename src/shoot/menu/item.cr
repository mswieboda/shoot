module Shoot::Menu
  class Item
    getter? selected
    getter label : String
    getter text

    Size = 72
    TextColor = SF::Color::White
    TextColorSelected = SF::Color::Green

    def initialize(x, y, label, selected = false, centered = true)
      @selected = selected

      @label = label
      @text = SF::Text.new(label, Font.default, Size)
      @text.fill_color = selected? ? TextColorSelected : TextColor

      if centered
        x -= @text.global_bounds.width / 2
        y -= @text.global_bounds.height / 2
      end

      @text.position = SF.vector2(x, y)
    end

    def update(frame_time)
    end

    def draw(window : SF::RenderWindow)
      window.draw(text)
    end

    def select
      @selected = true
      @text.fill_color = TextColorSelected
    end

    def deselect
      @selected = false
      @text.fill_color = TextColor
    end
  end
end
