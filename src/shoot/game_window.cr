module Shoot
  abstract class GameWindow
    getter window : SF::RenderWindow
    getter clock : SF::Clock
    getter? exit

    def initialize
      @window = SF::RenderWindow.new(SF::VideoMode.desktop_mode, "shoot", SF::Style::None)
      window.vertical_sync_enabled = true

      @exit = false
      @clock = SF::Clock.new
    end

    def run
      while window.open?
        while event = window.poll_event
          event(event)
        end

        window.close if exit?

        frame_time = clock.restart.as_seconds

        update(frame_time)

        window.clear(SF::Color.new(0, 0, 0))

        draw(window)

        window.display
      end
    end

    def event(event)
      case event
      when SF::Event::Closed
        window.close
      end
    end

    abstract def update(frame_time)

    abstract def draw(window : SF::RenderWindow)
  end
end
