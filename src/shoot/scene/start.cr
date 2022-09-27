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

    def update(frame_time, keys : Keys, mouse : Mouse, joysticks : Joysticks)
      items.update(frame_time, keys, mouse)

      # if keys.just_pressed?([Keys::Space, Keys::Enter])
      if joysticks.just_pressed?(0_u32, [1_u32, 2_u32, 3_u32, 4_u32, 5_u32])
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
