module Shoot
  abstract class GameWindow
    getter window : SF::RenderWindow
    getter clock : SF::Clock

    def initialize
      @window = SF::RenderWindow.new(SF::VideoMode.desktop_mode, "shoot")
      window.vertical_sync_enabled = true

      @clock = SF::Clock.new
    end

    def run
      while window.open?
        while event = window.poll_event
          case event
          when SF::Event::Closed
            window.close
          when SF::Event::KeyPressed
            if event.code.escape?
              window.close
            end
          end
        end

        frame_time = clock.restart.as_seconds

        update(frame_time)

        window.clear(SF::Color.new(0, 0, 0))

        draw(window)

        window.display
      end
    end

    abstract def update(frame_time)

    abstract def draw(window : SF::RenderWindow)
  end
end
