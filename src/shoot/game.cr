require "./ship"

module Shoot
  class Game
    def self.run
      mode = SF::VideoMode.new(1024, 780)
      window = SF::RenderWindow.new(mode, "shoot")
      window.vertical_sync_enabled = true

      ship = Ship.new
      clock = SF::Clock.new

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

        # update

        ship.update(frame_time)

        # draw

        window.clear(SF::Color.new(0, 0, 0))

        ship.draw(window)

        window.display
      end
    end
  end
end
