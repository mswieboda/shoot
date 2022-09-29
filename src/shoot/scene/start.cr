module Shoot::Scene
  class Start < GSF::Scene
    getter start_scene : Symbol?
    getter items

    def initialize
      super(:start)

      @start_scene = nil
      @items = GSF::MenuItems.new(
        font: Font.default,
        labels: ["horizontal", "freedom", "options", "exit"]
      )
    end

    def reset
      super

      @start_scene = nil
    end

    def update(frame_time, keys : Keys, mouse : Mouse, joysticks : Joysticks)
      items.update(frame_time, keys, mouse)

      # TODO: refactor this to some just_pressed?(:action) etc pattern per scene
      #       with defined input config per scene
      if keys.just_pressed?([Keys::Space, Keys::Enter]) ||
         joysticks.just_pressed?([Joysticks::A, Joysticks::B, Joysticks::X, Joysticks::Y])
        case items.focused
        when "horizontal"
          @start_scene = :horizontal
        when "freedom"
          @start_scene = :freedom
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
