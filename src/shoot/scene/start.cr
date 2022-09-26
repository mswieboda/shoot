module Shoot::Scene
  class Start < GSF::Scene
    property? start
    getter items

    def initialize
      super(:start)

      @start = false
      @items = GSF::MenuItems.new(
        font: Font.default,
        labels: ["start", "options", "something else", "exit"]
      )
    end

    def reset
      super

      @start = false
    end

    def update(frame_time, keys : Keys, mouse : Mouse)
      items.update(frame_time, keys, mouse)

      if keys.just_pressed?([Keys::Space, Keys::Enter])
        case items.focused
        when "start"
          @start = true
        when "exit"
          @exit = true
        end
      elsif keys.just_pressed?(Keys::Escape)
        @exit = true
      end
    end

    def draw(window : SF::RenderWindow)
      items.draw(window)
    end
  end
end
